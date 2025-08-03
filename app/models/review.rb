class Review < ApplicationRecord
  
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags
  has_many :entity_sentiments, dependent: :destroy
  
  include JpPrefecture
  jp_prefecture :prefecture_code

  belongs_to :user

  validates :title, presence: { message: 'は必須です' }
end