class SearchController < ApplicationController
  def index
    if params[:search]
      @list_course_search = Course.search_courses(params[:search]).page params[:page]
      @list_user_search = User.search_users(params[:search]).page params[:page]
    end
  end
end
