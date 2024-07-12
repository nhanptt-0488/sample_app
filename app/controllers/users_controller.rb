class UsersController < ApplicationController
  before_action :find_user, only: :show

  def show
    @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t("user_created_successfully")
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(User::ATTRIBUTES)
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:error] = t("user_not_found")
    redirect_to root_path
  end
end
