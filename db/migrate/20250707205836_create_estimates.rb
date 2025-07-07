class CreateEstimates < ActiveRecord::Migration[6.1]
  def change
    create_table :estimates do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :building_price
      t.integer :land_price
      t.integer :total_price

      t.timestamps
    end
  end
end
