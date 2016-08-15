class Trail < ApplicationRecord
  paginates_per 15

  belongs_to :creator, class_name: 'User'
  has_many :crumbs, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :followers, through: :favorites, source: :user
  has_many :actives, dependent: :destroy
  has_many :trail_users, through: :actives, source: :user
  has_many :used_trails, through: :actives, source: :user
  has_and_belongs_to_many :tags

  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

  def all_true
    if self.latitude && self.longitude
      incomplete = self.crumbs.keep_if {|c| c.latitude && c.longitude }
      if incomplete.empty?
        true
      else
        names = incomplete.map { |c| c.name }
        "All crumbs require latitude and longitude. Please return to #{names}"
      end
    else
      "A trail requires a base latitude and longitude."
    end
  end

def order_crumbs
  ordered = self.crumbs.sort {|a,b| a.created_at <=> b.created_at}
  ordered.each_with_index do |t, i|
    t.update_attribute(:order_number, i + 1)
    end
end

# def destroy_related
#   relations = Active.where(trail: self)
#   relations.each do |t|
#     t.destroy
#   end
#   relations = Favorite.where(trail: self)
#   relations.each do |t|
#     t.destroy
#   end
# end

end
