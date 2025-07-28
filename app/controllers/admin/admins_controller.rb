class Admin::AdminsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    admin = Admin.find(params[:id])
    admin.destroy
    redirect_to admin_users_path, notice: "管理者を削除しました。"
  end
end
