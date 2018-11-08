class CoursesController < ApplicationController
  before_action :load_course, only: :index

  def index
  end
  
  private
  def load_course
    @course = Course.find params[:id]
    @list_ratings_comments = Course.list_ratings_comment? params[:id]
  end
end
