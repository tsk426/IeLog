class Tag < ApplicationRecord

  OTHER_CATEGORY = 'その他'.freeze
  CATEGORIES = %w[間取り・空間 家事・生活 キッチン・水回り 外装・屋根 構造・性能].freeze

  has_many :review_tags, dependent: :destroy
  has_many :reviews, through: :review_tags

  has_many :estimate_tags, dependent: :destroy
  has_many :estimates, through: :estimate_tags

  validates :name, presence: true
  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 },
            if: -> { has_attribute?(:price) }
  validates :category,inclusion: { in: CATEGORIES + [OTHER_CATEGORY] },if: -> { has_attribute?(:category) }
  
  OTHER_CATEGORY = 'その他'.freeze
  CATEGORIES = %w[間取り・空間 家事・生活 キッチン・水回り 外装・屋根 構造・性能].freeze

  private

  def normalize_and_defaults
    self.name = name.to_s.strip

    self.price = 0 if has_attribute?(:price) && price.blank?

    if has_attribute?(:category) && category.blank?
      self.category = OTHER_CATEGORY
    end
  end
end