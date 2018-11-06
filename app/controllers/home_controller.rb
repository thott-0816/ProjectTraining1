class HomeController < ApplicationController
  def index
    @list_categories = Category.list_all_categories?
  end
end
