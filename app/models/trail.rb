class Trail < ApplicationRecord
  paginates_per 15

  belongs_to :creator, class_name: 'User'
  has_many :crumbs, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :followers, through: :favorites, source: :user

  has_many :actives, dependent: :destroy
  has_many :trail_users, through: :actives, source: :user
  has_many :used_trails, through: :actives, source: :user
  has_many :tag_trails
  has_many :tags, through: :tag_trails


  has_attached_file :img, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  validates_attachment_content_type :img, :content_type => /\Aimage\/.*\Z/

  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

def order_crumbs
  ordered = self.crumbs.sort {|a,b| a.created_at <=> b.created_at}
  ordered.each_with_index do |t, i|
    t.update_attribute(:order_number, i + 1)
    end
 end

def too_many_crumbs
  if self.crumbs.length < 1 || self.crumbs.length > 20
    self.errors.full_messages << "Trails must have between 1 and 20 crumbs."
  end
end



end
