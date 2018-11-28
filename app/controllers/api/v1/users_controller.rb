class Api::V1::UsersController < Api::BaseController
  skip_before_action :authenticate_request!
  
  swagger_controller :users, I18n.t("swagger.user.tile")

  swagger_api :create do
    summary I18n.t("swagger.user.summary")
    notes I18n.t("swagger.user.notes")
    param :form, "user[name]", :string, :required, I18n.t("swagger.user.name")
    param :form, "user[email]", :string, :required, I18n.t("swagger.user.email")
    param :form, "user[password]", :string, :required, I18n.t("swagger.user.password")
    param :form, "user[password_confirmation]", :string, :required, I18n.t("swagger.user.password_confirmation")
    param :form, "locale", :string, :required, I18n.t("swagger.locale")
    response :ok, I18n.t("swagger.sussces")
    response :bad_request, I18n.t("swagger.bad_request")
  end

  def create
    user = User.new user_params

    if user.save
      render_json user.load_attribute_user, I18n.t("user.create.sussces")
    else
      render_json nil, user.errors.messages, true, 400
    end
  end

  protected

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
