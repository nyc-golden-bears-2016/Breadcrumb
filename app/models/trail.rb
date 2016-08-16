class Trail < ApplicationRecord
	include PgSearch
  multisearchable :against => [:name, :description, :tags_name]

  belongs_to :creator, class_name: 'User'
  has_many :crumbs, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :followers, through: :favorites, source: :user

  has_many :actives, dependent: :destroy
  has_many :trail_users, through: :actives, source: :user
  has_many :used_trails, through: :actives, source: :user

  has_many :tag_trails
  has_many :tags, through: :tag_trails

  has_attached_file :img, required: false

  validates_attachment_content_type :img,
                                    :content_type => /^image\/(png|gif|jpeg)/,
                                    :message => 'only (png/gif/jpeg) images',
                                    :size => { in: 0..2.megabytes }

  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode

<<<<<<< 751fdbda84e0feccf07dca0620f57c02e4e4ea62
	def order_crumbs
	  ordered = self.crumbs.sort {|a,b| a.created_at <=> b.created_at}
	  ordered.each_with_index do |t, i|
	    t.update_attribute(:order_number, i + 1)
	    end
	 end

	def too_many_crumbs
	  if self.crumbs.length < 1 || self.crumbs.length > 20
			true
		end
	end

	end
=======
def order_crumbs
  ordered = self.crumbs.sort {|a,b| a.created_at <=> b.created_at}
  ordered.each_with_index do |t, i|
    t.update_attribute(:order_number, i + 1)
    end
 end


  def tags_name
    tags.name
  end



end
>>>>>>> reconfigure main search to include both tags and trails search
