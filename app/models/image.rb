class Image < ApplicationRecord
  belongs_to :crumb, required: false
  belongs_to :trail, required: false
  belongs_to :user, required: false

  validates :imageable_id, :imagable_type, presence: true

  has_attached_file :avatar, styles: {
  thumb: '100x100>',
  square: '200x200#',
  medium: '300x300>'
}

# Validate the attached image is image/jpg, image/png, etc
validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
