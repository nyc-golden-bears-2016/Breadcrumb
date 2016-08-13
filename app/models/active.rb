class Active < ApplicationRecord
  belongs_to :trail, required: false
  belongs_to :user, required: false


  def crumbs_available
    if self.trail.sequential
      self.trail.crumbs
    else
      num = (self.last_crumb_reached) + 1
      ordered = self.trail.crumbs.sort {|a,b| b.order_number <=> a.order_number}
      ordered.take_while {|t| t.order_number < num }
    end
  end
end
