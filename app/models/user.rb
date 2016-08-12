class User < ApplicationRecord
  attr_accessor :login

  has_many :created_trails, class_name: 'Trail', foreign_key: :creator_id, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_trails, through: :favorites, source: :trail
  has_many :experiences, dependent: :destroy
  has_many :walked_trails, through: :experiences, source: :trail
  has_many :images, as: :imageable, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :email, { :uniqueness => {
    :case_sensitive => false}, presence: true }
  # validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Email doesn't belong to a valid domain." }
  validates :password, length: { minimum: 8 }
  validate :validate_username

def self.find_first_by_auth_conditions(warden_conditions)
  conditions = warden_conditions.dup
  if login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  else
    if conditions[:username].nil?
      where(conditions).first
    else
      where(username: conditions[:username]).first
    end
  end
end


def validate_username
  if User.where(email: username).exists?
    errors.add(:username, :invalid)
  end
end
end
