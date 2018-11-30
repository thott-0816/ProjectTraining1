class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :load_all_categories, :load_cart

  class << self
    def default_url_options
      {locale: I18n.locale}
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: "text/html" }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: "text/html" }
    end
  end

  private

  def load_all_categories
    @categories = Category.root_category
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def namespace
    controller_name_segments = params[:controller].split("/")
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join("/").camelize
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, namespace)
  end

  def load_cart
    if user_signed_in?
      add_cart_item_login
      @cart_items = current_user.cart_items.includes(:course)
      @total_price = CartItem.total_price @cart_items
    else
      @array_course = Course.array_course session[:array_course_id]
      @total_price = CartItem.total_price_not_login @array_course
    end
  end

  def add_cart_item_login
    if session[:array_course_id]
      session[:array_course_id].each do |course_id|
        return if helpers.check_course(course_id)
        current_user.cart_items.create!(course_id: course_id) if current_user
        session[:array_course_id].delete(course_id)
      end
    end
  end
end
