class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  has_many :messages, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30 }
  validates :age, presence: true, numericality: true, inclusion: { in: 0..150 }
  validates :email,
            presence: true,
            uniqueness: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX }
end
