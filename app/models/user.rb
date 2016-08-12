class User < ApplicationRecord
  # has_secure_password

  has_many :created_trails, class_name: 'Trail', foreign_key: :creator_id, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_trails, through: :favorites, source: :trail
  has_many :experiences, dependent: :destroy
  has_many :walked_trails, through: :experiences, source: :trail
  has_many :images, as: :imageable, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :email, { uniqueness: true, presence: true }
  # validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Email doesn't belong to a valid domain." }
  validates :password, length: { minimum: 8 }

end
