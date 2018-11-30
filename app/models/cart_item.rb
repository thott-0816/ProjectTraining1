class CartItem < ApplicationRecord
  belongs_to :course
  belongs_to :user

  class << self
    def total_price cart_items
      cart_items.inject(0){|sum, item| sum + item.course.price_sale}
    end

    def total_price_not_login array_course
      array_course.inject(0){|sum, item| sum + item.price_sale}
    end
  end
end
