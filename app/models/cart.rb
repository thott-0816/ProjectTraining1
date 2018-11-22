class Cart < ApplicationRecord
  has_many :courses, dependent: :destroy
  belongs_to :user
end
