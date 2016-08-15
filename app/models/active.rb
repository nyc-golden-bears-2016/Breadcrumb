class Active < ApplicationRecord
  belongs_to :trail, required: false
  belongs_to :user, required: false
  has_many :active_crumbs, dependent: :destroy

  def crumbs_available
    if !self.trail.sequential
      self.active_crumbs
    else
      num = self.last_crumb_reached
      self.active_crumbs[0..(num)]
    end
  end

  def copy_crumbs
    self.trail.crumbs.each do |copy|
      ActiveCrumb.create(active: self, crumb: copy, order_number: copy.order_number)
    end
  end

end
