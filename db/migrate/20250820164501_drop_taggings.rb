class DropTaggings < ActiveRecord::Migration[6.1]
  def up
    drop_table :taggings, if_exists: true
  end

  def down
    create_table :taggings do |t|
      t.integer :tag_id
      t.string  :taggable_type
      t.integer :taggable_id
      t.string  :tagger_type
      t.integer :tagger_id
      t.string  :context, limit: 128
      t.datetime :created_at
      t.string  :tenant,  limit: 128
    end
    add_index :taggings, :context
  end
end
