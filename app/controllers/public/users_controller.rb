class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  

  def index
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
  
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
  
end
