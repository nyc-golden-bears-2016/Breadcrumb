class Trail < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :crumbs, dependent: :destroy
  belongs_to :favorite
  has_many :followers, through: :favorite, source: :user
  belongs_to :experience
  has_many :trail_users, through: :experience, source: :user
  has_and_belongs_to_many :tags
end
