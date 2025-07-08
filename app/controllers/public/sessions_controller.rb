class Public::SessionsController < Devise::SessionsController
  def guest_sign_in
    guest_user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
      user.is_public = true
      # その他制限を追加予定
    end
    sign_in guest_user
    redirect_to homes_top_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
