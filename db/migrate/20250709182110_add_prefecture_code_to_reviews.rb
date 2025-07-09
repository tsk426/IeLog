class AddPrefectureCodeToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :prefecture_code, :integer
  end
end
