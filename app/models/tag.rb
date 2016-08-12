class Tag < ApplicationRecord
  has_and_belongs_to_many :trails

  validates :subject, presence: true


  private
  
  def self.alphabetize
     the_class = self.all.to_a
     the_class.sort_by { |tag| tag.subject }
   end
end
