class Admin::CategoriesController < Admin::ApplicationController
  load_and_authorize_resource

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "add_success_category"
      redirect_to admin_dashboards_url
    else
      flash[:danger] = t "add_failed_category"
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :description, :parent_id, :thumbnail
  end
end
