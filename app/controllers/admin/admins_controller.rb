class Admin::AdminsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :ensure_not_last_admin, only: :destroy
  before_action :ensure_not_self,       only: :destroy

  def destroy
    admin = Admin.find_by(id: params[:id])
    if admin
      admin.destroy!
      redirect_to admin_users_path, notice: '管理者を削除しました。'
    else
      redirect_to admin_users_path, alert: '対象の管理者が見つかりませんでした。'
    end
  end

  private
  def ensure_not_last_admin
    if Admin.count <= 1
      redirect_to admin_users_path, alert: '最後の管理者は削除できません。'
    end
  end

  def ensure_not_self
    if current_admin && current_admin.id.to_s == params[:id].to_s
      redirect_to admin_users_path, alert: '自分自身は削除できません。'
    end
  end
end