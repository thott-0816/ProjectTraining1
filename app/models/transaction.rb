class Transaction < ApplicationRecord
  belongs_to :credit
  belongs_to :e_wallet
  validates :amount, numericality: {greater_than_or_equal_to: 0}
end
