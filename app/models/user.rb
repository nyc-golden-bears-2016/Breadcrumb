class User < ApplicationRecord
<<<<<<< 8f7df41d626ab0aadb471d1221131c72bffe9f61
  has_many :created_trails, class_name: 'Trail', dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_trails, through: :favorites, source: :trail
  has_many :experiences, dependent: :destroy
  has_many :walked_trails, through: :experiences, source: :trail
=======
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :trails
  has_many :walked_trails, through: :starred, source: :trail
>>>>>>> add 'devise' gem; create USER model/migration; migrate db
end
