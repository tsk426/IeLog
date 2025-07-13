class AddFloorTypeToEstimates < ActiveRecord::Migration[6.1]
  def change
    add_column :estimates, :floor_type, :string
  end
end
