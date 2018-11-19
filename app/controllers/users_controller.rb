class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :get_user

  def show
    @count_review = @user.courses.map(&:comments).flatten.size
    @courses = @user.courses.page(params[:page]).per(Settings.course.item)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def get_user
    redirect_to root_path unless @user = User.find_by(id: params[:id])
  end
end
