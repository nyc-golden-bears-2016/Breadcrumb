class Trail < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :crumbs, dependent: :destroy
  belongs_to :favorite, required: false
  has_many :followers, through: :favorite, source: :user
  belongs_to :experience, required: false
  has_many :trail_users, through: :experience, source: :user
  has_and_belongs_to_many :tags
  has_many :images, as: :imageable, dependent: :destroy

end
