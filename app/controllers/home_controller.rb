class HomeController < ApplicationController
  before_action :check_admin

  def index
    @list_categories = Category.list_all_categories?
  end

  def show; end

  private

  def check_admin
    redirect_to admin_path if current_user.role == "admin"
  end
end
