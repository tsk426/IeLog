class Review < ApplicationRecord
  
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags
  
  include JpPrefecture
  jp_prefecture :prefecture_code

  belongs_to :user

  acts_as_taggable_on :tags
  validates :title, presence: { message: 'は必須です' }
end