class AddTsuboToEstimates < ActiveRecord::Migration[6.1]
  def change
    add_column :estimates, :tsubo, :integer
  end
end
