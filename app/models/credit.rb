class Credit < ApplicationRecord
  belongs_to :e_wallet, optional: true
  has_many :transactions
end
