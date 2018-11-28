class CartItemsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!

  before_action :find_cart_item, only: :destroy

  def index; end

  def create
    return if helpers.check_course(params[:course_id])
    current_user.cart_items.create!(course_id: params[:course_id])
    load_cart 
  end

  def destroy
    if @cart_item.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_fail"
    end
    redirect_to cart_items_path
  end

  private

  def find_cart_item
    @cart_item = current_user.cart_items.find_by id: params[:id]

    return if @cart_item
    flash[:danger] = t ".not_cart_item"
    redirect_to cart_items_path
  end
end
