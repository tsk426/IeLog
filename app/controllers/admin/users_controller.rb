class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @admins = Admin.all.order(created_at: :desc)
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @comments = @user.comments
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました。"
  end
end
