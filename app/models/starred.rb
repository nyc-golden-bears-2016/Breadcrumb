class Starred < ApplicationRecord
  belongs_to :trail
  belongs_to :follower, class_name: 'User'
end
