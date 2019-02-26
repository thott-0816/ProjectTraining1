class Transaction < ApplicationRecord
  belongs_to :credit
  belongs_to :e_wallet
  validates :amount, numericality: {greater_than_or_equal_to: 0}
  enum transaction_status: {failed: 0, successed: 1}
end
