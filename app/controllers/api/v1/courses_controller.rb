class Api::V1::CoursesController < Api::BaseController
  skip_before_action :authenticate_request!

  swagger_controller :courses, I18n.t("swagger.course.title")

  swagger_api :show do
    summary I18n.t("swagger.course.summary")
    notes I18n.t("swagger.course.notes")
    param :path, :id, :integer, :required, I18n.t("swagger.course.category")
    param :form, "locale", :string, :required, I18n.t("swagger.locale")
    response :ok, I18n.t("swagger.sussces")
    response :not_found, I18n.t("swagger.not_found", model_name: "Course")
  end

  def show
    course = Course.find_by id: params[:id]
    if course
      render_json course.load_structure, I18n.t("course.show.sussces")
    else
      render_json nil, true, I18n.t("course.show.not_found"), 404
    end
  end
end
