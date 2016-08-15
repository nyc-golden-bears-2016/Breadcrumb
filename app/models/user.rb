class User < ApplicationRecord
  attr_accessor :login

  has_many :created_trails, class_name: 'Trail', foreign_key: :creator_id, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_trails, through: :favorites, source: :trail
  has_many :actives, dependent: :destroy
  has_many :walked_trails, through: :actives, source: :trail

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :email, { :uniqueness => {
    :case_sensitive => false}, presence: true }

  validate :validate_username

  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

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

  def nearby_trails
    trails = Trail.near([self.latitude, self.longitude], 10)
  end

  def set_coords(latitude, longitude)
    self.latitude = latitude
    self.longitude = longitude
    self.save
  end
end
