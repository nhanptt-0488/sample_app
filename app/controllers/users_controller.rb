class UsersController < ApplicationController
  before_action :logged_in_user, excpet: %i(show new create)
  before_action :set_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

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

  def index
    @pagy, @users = pagy User.all, items: Settings.users_per_page
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "users.update.success"
      redirect_to @user
    else
      flash.now[:danger] = t "users.update.failed"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.destroy.success"
    else
      flash[:danger] = t "users.destroy.failed"
    end
    redirect_to users_path
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "users.error.please_log_in"
    redirect_to login_path, status: :see_other
  end

  def correct_user
    return if current_user? @user

    flash[:danger] = t "users.error.not_correct_user"
    redirect_to root_path, status: :see_other
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
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
