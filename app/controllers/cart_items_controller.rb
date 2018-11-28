class CartItemsController < ApplicationController
  load_and_authorize_resource

  before_action :find_cart_item, only: :destroy

  def index; end

  def create
    if user_signed_in?
      return if helpers.check_course(params[:course_id])
      current_user.cart_items.create!(course_id: params[:course_id])
    else
      (session[:array_course_id] ||= []) << params[:course_id]
    end
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

  def destroy_cart_item_not_login
    session[:array_course_id].delete(params[:course_id])
    flash[:success] = t "cart_items.destroy.delete_success"
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
