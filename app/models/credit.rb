class Credit < ApplicationRecord
  belongs_to :e_wallet, optional: true
  has_many :transactions
  enum gender: {male: 0, female: 1, other: 2}
  enum card_type: {american_express: 0, discover_card: 1, jcb: 2, master_card: 3, visa: 4}
  validates :name, presence: true
  validates_length_of :phone, maximum: 25
  validates :bank, presence: true
  validates :card_type, presence: true
  validates :expiration_date, presence: true
  validates :number, numericality: {only_integer: true}
  validates_length_of :number, in: 13..19
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}

  scope :approved, ->{where approved: true}
  scope :connected, ->{where connected: true}
end
