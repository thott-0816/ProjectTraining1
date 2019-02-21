class Transaction < ApplicationRecord
  belongs_to :credit
  belongs_to :e_wallet

  validates :amount, numericality: {greater_than: 0}
  validates :confirmation_code, presence: true
  
  enum code_status: %i(not_entered entered)
  enum transaction_status: %i(fail success)

  def init_transaction code
    self.confirmation_code = code
    self.reset_sent_at = Time.zone.now
  end

  def code_expired?
    created_at > 2.minutes.ago
  end
end
