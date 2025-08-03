class CreateEntitySentiments < ActiveRecord::Migration[6.1]
  def change
    create_table :entity_sentiments do |t|
      t.references :review, null: false, foreign_key: true
      t.string :name
      t.float :score
      t.float :magnitude

      t.timestamps
    end
  end
end
