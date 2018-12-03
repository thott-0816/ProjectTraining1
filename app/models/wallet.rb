class Wallet < ApplicationRecord
  belongs_to :user
  
  validates :account, numericality: {greater_than_or_equal_to: 0}
  validates :user, uniqueness: true
end
