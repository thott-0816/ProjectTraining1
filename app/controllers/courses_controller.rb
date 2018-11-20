class CoursesController < ApplicationController
  load_and_authorize_resource find_by: :slug
  before_action :load_course, only: %i(show edit update destroy)
  before_action :load_all_course, only: :index

  def index
    redirect_to root_path if current_user.role == "student"
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.build course_params
    respond_to do |format|
      if @course.save
        format.html {
          flash[:success] = t "create_success"
          redirect_to new_course_lesson_path @course
        }
      else
        format.html {
          flash[:danger] = t "create_failed"
          render :new
        }
      end
      format.js
    end
  end

  def show; end

  def edit; end

  def update
    flash[:success] = t "update_success" if @course.update course_params
  end

  def destroy
    if @course.destroy
      flash[:success] = t "delete_success"
      redirect_to courses_path
    else
      flash[:danger] = t "delete_failed"
      redirect_to courses_path
    end
  end

  def newcomment
    @commentrate = CommentRate.new commentrate_params, current_user
    respond_to do |format|
      if @commentrate.save
        @flash = {text: t("course.create.success"), type: "success"}
      else
        @flash = {text: t("course.create.failed"), type: "danger"}
      end
      format.js
    end
  end

  private

  def course_params
    params.require(:course).permit :name, :description, :rate_average, :thumbnail, :category_id
  end

  def load_all_course
    @courses = current_user.courses.list_all?
              .by_name(params[:name])
              .by_category(params[:category_id])
              .by_author(params[:author_id])
              .by_description(params[:description])
  end

  def load_course
    @course = Course.friendly.find_by_slug params[:id]
    @ratings = Course.list_ratings_comment?(params[:id]).ratings
    @comments = Course.list_ratings_comment?(params[:id]).comments.page(params[:page]).per(5)
    @commentrate = CommentRate.new
    unless @course
      flash[:danger] = t "course_not_found"
      redirect_to courses_path
    end
  end

  def commentrate_params
    params.require(:comment_rate).permit :rating, :course_id, :content, :parent_id
  end
end
