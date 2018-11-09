class CoursesController < ApplicationController
  before_action :load_course, only: :index

  def index
  end

  private
  def load_course
    @course = Course.friendly.find_by_slug params[:id]
    @list_ratings_comments = Course.list_ratings_comment? params[:id]
    unless @course
      flash[:danger] = "error"
      redirect_to root_path
    end
  end
end
