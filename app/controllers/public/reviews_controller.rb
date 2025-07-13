class Public::ReviewsController < ApplicationController

  before_action :set_review, only: [:edit, :update, :destroy, :show]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @reviews = Review.includes(:user).order(created_at: :desc)
  end

  def show
    @review = Review.find(params[:id])
  end
  
  
  def new
    @review = Review.new
    @prefectures = JpPrefecture::Prefecture.all.map { |p| [p.name, p.name] }
  end

  def create
    @review = current_user.reviews.build(review_params)

    if @review.save
      redirect_to review_path(@review), notice: 'レビューを投稿しました。'
    else
      @prefectures = JpPrefecture::Prefecture.all.map { |p| [p.name, p.name] }
      flash.now[:alert] = '投稿に失敗しました。'
      render :new
    end
  end


  def edit
    @review = Review.find(params[:id])
    authorize_user!
    @prefectures = JpPrefecture::Prefecture.all.map { |p| [p.name, p.name] }
  end

  def update
    @review = Review.find(params[:id])
    authorize_user!
    if @review.update(review_params)
      redirect_to @review, notice: 'レビューを更新しました。'
    else
      @prefectures = JpPrefecture::Prefecture.all.map { |p| [p.name, p.name] }
      render :edit
    end
  end
  

  def destroy
    @review.destroy
    redirect_to reviews_path, notice: 'レビューを削除しました。'
  end

  require 'jp_prefecture'

  private

  def set_review
    @review = Review.find_by(id: params[:id])
    unless @review
      redirect_to reviews_path, alert: 'レビューが見つかりませんでした。'
    end
  end

  def authorize_user!
    redirect_to root_path, alert: '操作が許可されていません。' unless @review.user == current_user
  end
  
  def review_params
    params.require(:review).permit(
      :title, :body, :housemaker,
      :house_budget, :land_budget,
      :prefecture_code, :city,
      :floor_plan, :is_public,
      tag_list: []
    )
  end
end