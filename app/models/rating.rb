class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :course

  scope :group_rating?, -> {order(rating: :desc).group(:rating).count(:rating)}
end
