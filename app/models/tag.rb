class Tag < ApplicationRecord
  has_many :review_tags, dependent: :destroy
  has_many :reviews, through: :review_tags

  has_many :estimate_tags, dependent: :destroy
  has_many :estimates, through: :estimate_tags

  validates :name, presence: true
  validate :category_presence

  private

  def category_presence
    if category.blank?
      errors.add(:category, "を入力するか、既存カテゴリから選択してください")
    end
  end
end