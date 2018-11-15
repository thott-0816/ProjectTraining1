class HomeController < ApplicationController
  before_action :check_admin
  authorize_resource :class => false

  def index
    @list_categories = Category.list_all_categories?
  end

  def show; end

  private

  def check_admin
    redirect_to admin_path if current_user.role == "admin"
  end
end
