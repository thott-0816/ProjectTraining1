class Admin::LessonsController < Admin::ApplicationController
  load_and_authorize_resource find_by: :slug

  before_action :get_course, only: %i(index create destroy)
  before_action :get_lesson, only: :destroy

  def index
    @lessons = @course.lessons
    @lesson = Lesson.new
  end

  def new; end

  def create
    @lesson = @course.lessons.build lesson_params
    if @lesson.save
      flash[:success] = t "create_success"
      redirect_to admin_course_lessons_path @course
    else
      flash[:danger] = t "create_failed"
      render :new
    end
  end

  def destroy
    if @lesson.destroy
      flash[:success] = t "delete_success"
    else
      flash[:danger] = t "delete_failed"
    end
    redirect_to admin_course_lessons_path @course
  end

  private

  def get_course
    @course = Course.friendly.find_by_slug params[:course_id]
    unless @course
      flash[:danger] = t "course_not_found"
      redirect_to admin_courses_path
    end
  end

  def get_lesson
    redirect_to admin_courses_path unless @lesson = Lesson.friendly.find_by_slug(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit :course_id, :name, :video_url
  end
end
