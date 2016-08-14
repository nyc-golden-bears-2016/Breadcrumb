class Crumb < ApplicationRecord
  paginates_per 15

  belongs_to :trail



end
