class Api::SessionsController < Api::BaseController
  skip_before_action :authenticate_request!
  before_action :load_user_authentication, only: :create

  def create
    render json:
    {
      status: 200,
      error: false,
      message: "",
      data: @user.load_attribute_user
    }, status: 200
  end

  private

  def user_params
    params.require(:user).permit :email, :password
  end

  def load_user_authentication
    @user = User.find_by email: user_params[:email]

    return if @user && @user.valid_password?(user_params[:password])
    render json: {
      status: 400,
      error: true,
      message: "can dang nhap",
      data: nil
    }, status: 400
  end
end
