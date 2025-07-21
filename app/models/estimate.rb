class Estimate < ApplicationRecord
  belongs_to :user

  has_many :estimate_tags, dependent: :destroy
  has_many :tags, through: :estimate_tags

  def total_price
    building = building_price || 0
    land = land_price || 0
    fixed = 600
    building + land + fixed
  end
end
