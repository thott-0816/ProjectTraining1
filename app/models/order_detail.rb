class OrderDetail < ApplicationRecord
  has_many :courses, dependent: :destroy
  belongs_to :order
end
