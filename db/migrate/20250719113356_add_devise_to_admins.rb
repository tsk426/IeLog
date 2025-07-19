class AddDeviseToAdmins < ActiveRecord::Migration[6.1]
  def change
    change_table :admins, bulk: true do |t|
      # 既に存在しているカラムには変更を加えない
      t.datetime :reset_password_sent_at, if_not_exists: true
      t.datetime :remember_created_at, if_not_exists: true
    end

    # インデックスを追加する（必要に応じて）
    add_index :admins, :reset_password_token, unique: true unless index_exists?(:admins, :reset_password_token)
  end
end
