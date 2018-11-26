class CartItem < ApplicationRecord
  belongs_to :course
  belongs_to :user

  class << self
    def total_price cart_items
      cart_items.inject(0){|sum, item| sum + item.course.price_sale}
    end
  end
end
