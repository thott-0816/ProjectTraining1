class EWallet < ApplicationRecord
  belongs_to :user, inverse_of: :e_wallet
  has_many :transactions, dependent: :destroy
  has_many :payings, dependent: :destroy
  has_many :credits, dependent: :destroy
  validates :balances, numericality: {greater_than_or_equal_to: 0}
  validates :user, uniqueness: true
end
