  class Public::ReviewsController < ApplicationController
  before_action :ensure_guest_signed_in, only: [:index]
  before_action :notice_for_guest_browsing, only: [:index]
  before_action :set_review, only: [:edit, :update, :destroy, :show]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  before_action :reject_guest_user, except: [:index]

  def index
    @reviews = Review.includes(:user).order(created_at: :desc)
    @tags = Tag.all
  end

  def show
    @review = Review.find(params[:id])
    @reviews = Review.includes(:user).order(created_at: :desc)
  end

  def new
    @review = Review.new
    @prefectures = JpPrefecture::Prefecture.all.map { |p| [p.name, p.name] }
    @comment = Comment.new
    @comments = @review.comments.includes(:user)
    @tags = Tag.all
  end

  def create
    @review = current_user.reviews.build(review_params)
  
    # 投稿内容の感情分析
    sentiment_score = analyze_sentiment(@review.body)
  
    # 攻撃的な内容を判断する閾値を設定（例: -0.7以下）
    if sentiment_score < -0.7
      flash.now[:alert] = '投稿が攻撃的な内容を含んでいるため、投稿できません。'
      @prefectures = JpPrefecture::Prefecture.all.map { |p| [p.name, p.name] }
      @tags = Tag.all
      return render :new
    end
  
    # 投稿が攻撃的でない場合、保存処理を続ける
    if @review.save
      # タグの紐づけ
      if params[:review][:tag_ids]
        tag_ids = params[:review][:tag_ids].reject(&:blank?)
        tag_ids.each do |tag_id|
          @review.review_tags.create(tag_id: tag_id)
        end
      end
  
      # エンティティ感情分析の保存
      begin
        results = Language.get_entity_sentiment(@review.body)
        results.each do |entity|
          @review.entity_sentiments.create!(
            name: entity[:name],
            score: entity[:score],
            magnitude: entity[:magnitude]
          )
        end
      rescue => e
        Rails.logger.error("エンティティ感情分析の取得に失敗: #{e.message}")
        # 必須でなければ無視、または通知
      end
  
      redirect_to review_path(@review), notice: 'レビューを投稿しました。'
    else
      @prefectures = JpPrefecture::Prefecture.all.map { |p| [p.name, p.name] }
      @tags = Tag.all
      flash.now[:alert] = '投稿に失敗しました。'
      render :new
    end
  end

  def search
    @tags = Tag.all
    @reviews = Review.includes(:tags)  
    if params[:keyword].present?
      keyword = params[:keyword]
      @reviews = @reviews.where("title LIKE :kw OR body LIKE :kw", kw: "%#{keyword}%")
    end 
    if params[:tag_id].present?
      @reviews = @reviews.joins(:review_tags).where(review_tags: { tag_id: params[:tag_id] })
    end  
    @reviews = @reviews.distinct.order(created_at: :desc)
    render :index
  end

  def edit
    @prefectures = JpPrefecture::Prefecture.all.map { |p| [p.name, p.name] }
    @tags = Tag.all
  end

  def update
    # 更新前に投稿内容の感情分析を行う
    sentiment_score = analyze_sentiment(review_params[:body])
  
    # 攻撃的な内容を判断する閾値を設定（例: -0.7以下）
    if sentiment_score < -0.7
      flash.now[:alert] = '更新内容が攻撃的な内容を含んでいるため、投稿できません。'
      @prefectures = JpPrefecture::Prefecture.all.map { |p| [p.name, p.name] }
      @tags = Tag.all
      return render :edit
    end
  
    # 更新処理
    if @review.update(review_params)
      # タグの更新
      @review.tags = Tag.where(id: params[:review][:tag_ids]) if params[:review][:tag_ids]
  
      # エンティティ感情分析の保存（更新時にも同様に保存）
      begin
        results = Language.get_entity_sentiment(@review.body)
        results.each do |entity|
          @review.entity_sentiments.create!(
            name: entity[:name],
            score: entity[:score],
            magnitude: entity[:magnitude]
          )
        end
      rescue => e
        Rails.logger.error("エンティティ感情分析の取得に失敗: #{e.message}")
      end
  
      redirect_to review_path(@review), notice: 'レビューを更新しました。'
    else
      flash.now[:alert] = '投稿の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path, notice: 'レビューを削除しました。'
  end

  require 'jp_prefecture'

  private

  def reject_guest_user
    if current_user.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーはこの操作を行えません。'
    end
  end

  def set_review
    @review = Review.find_by(id: params[:id])
    unless @review
      redirect_to reviews_path, alert: 'レビューが見つかりませんでした。'
    end
  end

  def authorize_user!
    redirect_to root_path, alert: '操作が許可されていません。' unless @review.user == current_user
  end

  def ensure_guest_signed_in
    return if user_signed_in?

    redirect_to guest_sign_in_path(redirect_to: reviews_path), method: :post
  end

  def notice_for_guest_browsing
    if current_user&.email == 'guest@example.com'
      flash.now[:info] = "会員登録せずにチラ見中です。レビュー一覧は閲覧できますが、投稿やコメントにはログインが必要です。"
    end
  end

  def review_params
    params.require(:review).permit(
      :title, :body, :housemaker,
      :house_budget, :land_budget,
      :prefecture_name, :city_name,
      :floor_plan, :is_public,
      tag_ids: []
    )
  end

  def analyze_sentiment(text)
    # Google APIで感情分析を実行
    results = Language.get_entity_sentiment(text)
    # ネガティブなスコアの合計を算出（ポジティブ/ネガティブスコアを使っても良い）
    total_score = results.sum { |entity| entity[:score].to_f }

    return total_score
  end

end