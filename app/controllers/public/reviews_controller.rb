class Public::ReviewsController < ApplicationController
  def index
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
  end

  def update
  end

  def destroy
  end

  require 'jp_prefecture'

  private
  
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