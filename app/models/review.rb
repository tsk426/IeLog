class Review < ApplicationRecord
  
  has_many :likes, dependent: :destroy
  
  include JpPrefecture
  jp_prefecture :prefecture_code

  belongs_to :user

  acts_as_taggable_on :tags
end