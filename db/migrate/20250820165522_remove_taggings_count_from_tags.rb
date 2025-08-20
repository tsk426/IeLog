class RemoveTaggingsCountFromTags < ActiveRecord::Migration[6.1]
  def change
    remove_column :tags, :taggings_count, :integer, default: 0, if_exists: true
  end
end