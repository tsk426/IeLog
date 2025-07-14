class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :reject_guest_user, only: [:show, :index, :edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.where.not(email: 'guest@example.com')
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    # パスワード未入力時は更新対象から外す
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'プロフィールを更新しました。'
    else
      flash.now[:alert] = '更新に失敗しました。'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :password, :password_confirmation)
  end

  # ゲストユーザー制限
  def reject_guest_user
    if current_user.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーはこの操作を行えません。'
    end
  end
end
