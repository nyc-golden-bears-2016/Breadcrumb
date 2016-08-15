class ActiveCrumb < ApplicationRecord
  belongs_to :active
  belongs_to :crumb
end
