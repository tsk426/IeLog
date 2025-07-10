class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    @liked_reviews = current_user.liked_reviews
  end

  def create
    @review = Review.find(params[:review_id])
    current_user.likes.create(review: @review)
    redirect_to review_path(@review)
  end

  def destroy
    @review = Review.find(params[:review_id])
    current_user.likes.find_by(review: @review)&.destroy
    redirect_to review_path(@review)
  end
end