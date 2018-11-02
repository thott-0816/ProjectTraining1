class Course < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :category
  belongs_to :user
end
