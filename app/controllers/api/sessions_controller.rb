class Api::SessionsController < Api::BaseController
  skip_before_action :authenticate_request!
  before_action :load_user_authentication, only: :create

  swagger_controller :sessions, I18n.t("swagger.sessions.tile")

  swagger_api :create do
    summary I18n.t("swagger.sessions.summary")
    notes I18n.t("swagger.sessions.notes")
    param :form, "user[email]", :string, :required, I18n.t("swagger.sessions.email")
    param :form, "user[password]", :string, :required, I18n.t("swagger.sessions.password")
    param :form, "locale", :string, :required, I18n.t("swagger.locale")
    response :ok, I18n.t("swagger.sussces")
    response :bad_request, I18n.t("swagger.bad_request")
  end

  def create; end

  private

  def user_params
    params.require(:user).permit :email, :password
  end

  def load_user_authentication
    @user = User.find_by email: user_params[:email]
    if @user && @user.valid_password?(user_params[:password])
      render_json @user.load_attribute_user, I18n.t("session.create.sussces")
    else
      render_json nil, I18n.t("session.create.failed"), true, 400
    end
  end
end
