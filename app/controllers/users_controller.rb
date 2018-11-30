class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :get_user, only: :show

  def show
    @count_review = @user.courses.map(&:comments).flatten.size
    @courses = @user.courses.page(params[:page]).per(Settings.course.item)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update_wallet
    @mess = "You need login"
    if user_signed_in?
      @giftcode = Giftcode.find_by code: params[:code]
      if @giftcode
        @mess = "" if @current_user.update_wallet? @giftcode.value
      else
        @mess = "code not found" 
      end
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def get_user
    redirect_to root_path unless @user = User.find_by(id: params[:id])
  end
end
