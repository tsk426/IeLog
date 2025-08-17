class AddFreeTextLocationToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :prefecture_name, :string
    add_column :reviews, :city_name, :string
  end
end
