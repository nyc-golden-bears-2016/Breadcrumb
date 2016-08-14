class Trail < ApplicationRecord
  paginates_per 15

  belongs_to :creator, class_name: 'User'
  has_many :crumbs, dependent: :destroy
  has_many :favorites
  has_many :followers, through: :favorites, source: :user
  belongs_to :active, required: false
  has_many :trail_users, through: :active, source: :user
  has_and_belongs_to_many :tags


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


end
