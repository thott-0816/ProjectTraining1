class Admin::CategoriesController < Admin::ApplicationController
  load_and_authorize_resource

  before_action :get_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.get_all_category
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "add_success_category"
      redirect_to admin_categories_url
    else
      flash[:danger] = t "add_failed_category"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "update_success"
      redirect_to admin_categories_url
    else
      flash[:danger] = t "update_failed"
      render :edit
    end
  end

  def destroy
    if @category.courses.present?
      message_category
    else
      if !@category.children.present?
        delete_category
      else
        found = false
        @category.descendents.each do |category|
          if category.courses.present?
            found = true
            message_category
            break
          end
        end
        unless found
          delete_category
        end
      end
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :description, :parent_id, :thumbnail
  end

  def get_category
    redirect_to root_url unless @category = Category.find_by(id: params[:id])
  end

  def message_category
    flash[:warning] = t "delete_warning"
    redirect_to admin_categories_url
  end

  def delete_category
    if @category.destroy
      flash[:success] = t "delete_success"
    else
      flash[:danger] = t "delete_failed"
    end
    redirect_to admin_categories_url
  end
end
