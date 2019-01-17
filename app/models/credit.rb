class Credit < ApplicationRecord
  belongs_to :e_wallet
  has_many :transactions
end
