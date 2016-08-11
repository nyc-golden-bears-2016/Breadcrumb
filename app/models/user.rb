class User < ApplicationRecord

  has_many :created_trails, class_name: 'Trail', dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_trails, through: :favorites, source: :trail
  has_many :experiences, dependent: :destroy
  has_many :walked_trails, through: :experiences, source: :trail

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end


