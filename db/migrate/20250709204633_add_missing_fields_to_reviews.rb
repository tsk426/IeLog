class AddMissingFieldsToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :city, :string
    add_column :reviews, :floor_plan, :string
    add_column :reviews, :is_public, :boolean
  end
end
