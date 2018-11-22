class Api::V1::CoursesController < Api::BaseController
  before_action :load_all_course, only: :index

  swagger_controller :users, "User Management"

  swagger_api :index do
    summary "Fetches all User items"
    notes "This lists all the active users"
    param :query, :page, :integer, :optional, "Page number"
    param :path, :nested_id, :integer, :optional, "Team Id"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable
  end

  def index
    render json: {
      error: false,
      message: "haiz",
      data: @courses
    }, status: 500
  end

  private

  def load_all_course
    @courses = User.first.courses.list_all?
  end
end
