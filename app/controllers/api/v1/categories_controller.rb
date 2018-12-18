class Api::V1::CategoriesController < Api::BaseController
  skip_before_action :authenticate_request!

  swagger_controller :categorys, I18n.t("swagger.category.tile")

  swagger_api :index do
    summary I18n.t("swagger.category.index.summary")
    notes I18n.t("swagger.category.index.notes")
    param :form, "locale", :string, :required, I18n.t("swagger.locale")
    response :ok, I18n.t("swagger.sussces")
    response :not_found, I18n.t("swagger.not_found", model_name: "Category")
  end

  swagger_api :show do
    summary I18n.t("swagger.category.show.summary")
    notes I18n.t("swagger.category.show.notes")
    param :path, :id, :integer, :required, I18n.t("swagger.category.show.category")
    param :form, "locale", :string, :required, I18n.t("swagger.locale")
    response :ok, I18n.t("swagger.sussces")
    response :not_found, I18n.t("swagger.not_found", model_name: "Category")
  end

  def index
    category = Category.load_categorys
    if category
      render_json category, I18n.t("category.index.sussces"), false, 200
    else
      render_json true, I18n.t("category.index.not_found"), 200
    end
  end

  def show
    category = Category.find_by(id: params[:id])
    if category
      render_json category.load_structure, I18n.t("category.show.sussces"), false, 200
    else
      render_json nil, I18n.t("category.show.not_found"), true, 200
    end
  end
end
