class Review < ApplicationRecord
  include JpPrefecture
  jp_prefecture :prefecture_code

  belongs_to :user

  acts_as_taggable_on :tags
end