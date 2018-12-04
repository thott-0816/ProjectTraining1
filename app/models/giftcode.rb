class Giftcode < ApplicationRecord
  validates :code, uniqueness: true

  scope :list_all?, -> { order(value: :asc).select :code, :value }
end
