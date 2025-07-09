class AddBudgetFieldsToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :house_budget, :integer
    add_column :reviews, :land_budget, :integer
  end
end
