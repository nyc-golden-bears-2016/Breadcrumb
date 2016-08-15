class Tag < ApplicationRecord
	# include PgSearch
 #  multisearchable :against => [:subject]

  has_and_belongs_to_many :trails

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
