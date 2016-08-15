class Tag < ApplicationRecord

  has_many :tag_trails
  has_many :trails, through: :tag_trails


  validates :subject, presence: true


def self.search(search)
  where("subject LIKE ?", "%#{search}%") 
end

  private

  def self.alphabetize
     the_class = self.all.to_a
     the_class.sort_by { |tag| tag.subject }
   end
end
