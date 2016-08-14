class Active < ApplicationRecord
  belongs_to :trail, required: false
  belongs_to :user, required: false

  def crumbs_available
    if !self.trail.sequential
      self.trail.crumbs
    else
      num = self.last_crumb_reached
      available = []
      ordered = self.trail.crumbs.sort {|a,b| a.order_number <=> b.order_number}
      ordered.each_with_index do |t, i|
      	if i <= num
      		available << t
      	end
      end
    available
  end
end

end
