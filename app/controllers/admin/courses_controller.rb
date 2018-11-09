class Admin::CoursesController < Admin::ApplicationController
  load_and_authorize_resource find_by: :slug
  before_action :init_course, only: :new
  before_action :load_all_course, only: :index
  before_action :load_course, only: %i(edit update destroy)

  def create
    @course = current_user.courses.build course_params
    if @course.save
      flash[:success] = t "create_success"
    else
      flash[:danger] = t "create_failed"
    end
  end

  def destroy
    if @courses.destroy
      flash[:success] = t "delete_success"
      redirect_to admin_courses_path
    else
      flash[:danger] = t "delete_failed"
      redirect_to admin_courses_path
    end
  end

  def edit; end

  def index; end

  def new; end

  def show; end

  def update
    flash[:success] = t "update_success" if @course.update course_params
  end

  private

  def init_course
    @course = Course.new
  end

  def course_params
    params.require(:course).permit :name, :description, :rate_average, :thumbnail, :category_id
  end

  def load_all_course
    @courses = Course.list_all?
              .by_name(params[:name])
              .by_category(params[:category_id])
              .by_author(params[:author_id])
              .by_description(params[:description])
  end

  def load_course
    @course = Course.friendly.find_by_slug params[:id]
    unless @course
      flash[:danger] = t "course_not_found"
      redirect_to admin_courses_path
    end
  end
end
