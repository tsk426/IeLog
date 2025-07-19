class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @reviews = Review.includes(:user).order(created_at: :desc)
  end

  def show
    @review = Review.find(params[:id])
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to admin_reviews_path, notice: "レビューを削除しました。"
  end
end