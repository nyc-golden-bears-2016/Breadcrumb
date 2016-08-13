class Active < ApplicationRecord
  belongs_to :trail, required: false
  belongs_to :user, required: false
end
