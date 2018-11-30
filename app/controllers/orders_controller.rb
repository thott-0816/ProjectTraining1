class OrdersController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(created_at: :desc)
      .page(params[:page]).per Settings.per_page
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        order = current_user.orders.create! total: @total_price, status: 1
        @cart_items.each do |cart_item|
          order.order_details.create! course_id: cart_item.course.id,
            price: cart_item.course.price_sale
        end
        new_account = current_user.wallet.account - @total_price
        current_user.wallet.update! account: new_account
        @cart_items.destroy_all
      end
      flash[:success] = t "orders.purchase_success"
    rescue => exception
      flash[:danger] = exception
    end
    redirect_to cart_items_path
  end
end
