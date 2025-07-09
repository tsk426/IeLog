class AddHousemakerToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :housemaker, :string
  end
end
