class AddGradeToEstimates < ActiveRecord::Migration[6.1]
  def change
    add_column :estimates, :grade, :string
  end
end
