class CoursesController < ApplicationController
  before_action :load_course, only: :show

  def show; end

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

  def load_course
    @course = Course.friendly.find_by_slug params[:id]
    @list_ratings_comments = Course.list_ratings_comment? params[:id]
    @commentrate = CommentRate.new
    unless @course
      flash[:danger] = "error"
      redirect_to root_path
    end
  end

  def commentrate_params
    params.require(:comment_rate).permit :rating, :course_id, :content, :parent_id
  end
end
