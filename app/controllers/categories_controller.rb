class CategoriesController < ApplicationController
  before_action :get_category

  def show
    @count_course = @category.courses.size
    @courses = @category.courses.page(params[:page]).per(Settings.course.item)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def get_category
    redirect_to root_url unless @category = Category.friendly.find_by_slug(params[:id])
  end
end
