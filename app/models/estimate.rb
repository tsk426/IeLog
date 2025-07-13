class Estimate < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags

  def total_price
    building = building_price || 0
    land = land_price || 0
    fixed = 600
    building + land + fixed
  end
end
