class ApplicationController < ActionController::Base
  # サインアップ後の遷移先
  def after_sign_up_path_for(resource)
    user_path(resource)
  end

# ログイン後の遷移先
def after_sign_in_path_for(resource)
  if resource.is_a?(Admin)
    admin_users_path  # 管理者ログイン後の遷移先（お好みで変更）
  else
    user_path(resource)  # 一般ユーザーは従来通り
  end
end

# ログアウト後の遷移先
def after_sign_out_path_for(resource_or_scope)
  if resource_or_scope == :admin
    new_admin_session_path  # 管理者はログイン画面へ
  else
    root_path  # 一般ユーザーはトップページ
  end
end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone_number])
  end

end
