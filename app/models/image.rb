class Image < ApplicationRecord
  belongs_to :crumb, required: false
  belongs_to :trail, required: false
  belongs_to :user, required: false

  validates :imageable_id, :imagable_type, presence: true
end
