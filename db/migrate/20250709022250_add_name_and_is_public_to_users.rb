class AddNameAndIsPublicToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :is_public, :boolean
  end
end
