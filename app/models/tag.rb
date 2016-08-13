class Tag < ApplicationRecord
<<<<<<< 151a128ef64dc6d850972d2b67998f679d8c39c5
  has_many :trails
  has_many :trails, through: :tag_trails
=======
	include PgSearch
  multisearchable :against => [:subject]

  has_and_belongs_to_many :trails
>>>>>>> get basic search to work on console

  validates :subject, presence: true


  private

  def self.alphabetize
     the_class = self.all.to_a
     the_class.sort_by { |tag| tag.subject }
   end
end
