class TagTrail < ApplicationRecord
  belongs_to :trail
  belongs_to :tag
end
