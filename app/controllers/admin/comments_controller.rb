class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @comments = Comment.includes(:user, :review).order(created_at: :desc)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_back fallback_location: admin_users_path, notice: "コメントを削除しました。"
  end
end
