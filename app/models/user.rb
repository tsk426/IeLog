class User < ApplicationRecord

  has_many :reviews, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーション
  validates :name, presence: true
  validates :phone_number, presence: true

  def guest?
    email == 'guest@example.com'
  end
end