class Admin::UsersController < Admin::ApplicationController
  load_and_authorize_resource

  before_action :find_user, only: %i(edit update destroy)

  def index
    @users = User.select(:id, :name, :email, :role, :avatar)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    flash[:success] = t ".create_success" if @user.save
  end

  def edit; end

  def update
    flash[:success] = t ".update_success" if @user.update user_params
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".destroy_success"
      redirect_to admin_users_path
    else
      flash[:danger] = t ".destroy_fail"
      redirect_to admin_users_path
    end
  end

  private
  
  def user_params
    params.require(:user).permit :name, :email, :password,
      :role
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "users.not_user"
    redirect_to root_path
  end
end
