class User < ApplicationRecord
  has_many :trails
  has_many :walked_trails, through: :starred, source: :trail
end
