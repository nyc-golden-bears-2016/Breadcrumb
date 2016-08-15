class Crumb < ApplicationRecord
  paginates_per 15

  belongs_to :trail

  has_attached_file :img, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  validates_attachment_content_type :img, :content_type => /\Aimage\/.*\Z/

end
