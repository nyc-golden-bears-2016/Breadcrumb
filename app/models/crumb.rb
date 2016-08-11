class Crumb < ApplicationRecord
  belongs_to :trail
  has_many :images
  has_many :sounds
end
