class CreateEstimateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :estimate_tags do |t|
      t.references :estimate, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :estimate_tags, [:estimate_id, :tag_id], unique: true
  end
end