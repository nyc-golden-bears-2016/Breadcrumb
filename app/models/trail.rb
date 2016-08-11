class Trail < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :crumbs
  has_and_belongs_to_many :followers, through: :starred, source: :follower
end
