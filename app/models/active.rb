class Active < ApplicationRecord
  belongs_to :trail, required: false
  belongs_to :user, required: false

  def crumbs_available
    if !self.trail.sequential
      self.trail.crumbs
    else
      num = self.last_crumb_reached
      self.trail.crumbs[0..(num-1)]
    end
  end

end
