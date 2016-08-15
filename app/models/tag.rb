class Tag < ApplicationRecord
  has_many :tag_trails
  has_many :trails, through: :tag_trails

  validates :subject, presence: true

   def self.search(search)
     where("subject LIKE ?", "%#{search}%")
   end

end
