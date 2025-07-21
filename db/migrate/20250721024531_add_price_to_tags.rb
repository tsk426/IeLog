class AddPriceToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :price, :integer
  end
end
