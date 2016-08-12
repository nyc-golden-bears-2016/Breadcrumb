class Crumb < ApplicationRecord
  paginates_per 15

  belongs_to :trail
  has_many :images
  has_many :sounds
  has_many :images, as: :imageable, dependent: :destroy
end
