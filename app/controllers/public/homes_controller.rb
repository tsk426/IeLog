class Public::HomesController < ApplicationController

  before_action :redirect_to_confirm_if_signed_in, only: :top

  def top; end
  def about; end

  def confirm_logout_to_home
    redirect_to homes_top_path unless user_signed_in? || admin_signed_in?
  end

  def logout_to_home
    sign_out_all_scopes
    reset_session
    redirect_to homes_top_path, notice: 'ログアウトしました（トップページに戻りました）'
  end

  private

  def redirect_to_confirm_if_signed_in
    redirect_to confirm_logout_to_home_path if user_signed_in? || admin_signed_in?
  end

end
