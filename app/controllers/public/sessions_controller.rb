class Public::SessionsController < Devise::SessionsController
  def guest_sign_in
    guest_user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
      user.phone_number = '000-0000-0000'
      user.is_public = true
      # その他制限を追加予定
    end
    sign_in guest_user
    redirect_to reviews_path, notice: 'ようこそ、ゲストさん'

  end
end
