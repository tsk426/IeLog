class Review < ApplicationRecord
  
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags
  has_many :entity_sentiments, dependent: :destroy

  belongs_to :user
  
  #include JpPrefecture
  #jp_prefecture :prefecture_code

  #before_validation :normalize_location
  #validates :prefecture_name, length: { maximum: 20 }, allow_blank: true
  #validates :city_name,       length: { maximum: 50 }, allow_blank: true
  
  #validates :title, presence: { message: 'は必須です' }

  before_validation :normalize_location

  def display_prefecture
    # 新カラムがあればそれを最優先
    return prefecture_name if respond_to?(:prefecture_name) && prefecture_name.present?

    # jp_prefecture をまだ使っている場合のフォールバック
    return prefecture.name if respond_to?(:prefecture) && prefecture.present?

    # 数値コードだけ入っている旧データ用の保険
    if respond_to?(:prefecture_code) && prefecture_code.present?
      begin
        return JpPrefecture::Prefecture.find(prefecture_code)&.name
      rescue
        # gemを外した場合でも落ちないように無視
      end
    end

    nil
  end

  def display_city
    # 新カラムがあれば最優先
    return city_name if respond_to?(:city_name) && city_name.present?

    # 関連(city)があれば
    return city.name if respond_to?(:city) && city.present?

    # stringカラムで :city を持っている旧データにも一応対応
    return self[:city] if attributes.key?('city') && self[:city].present?

    nil
  end

  private
  def normalize_location
    self.prefecture_name = prefecture_name.to_s.strip.presence
    self.city_name       = city_name.to_s.strip.presence
  end
end