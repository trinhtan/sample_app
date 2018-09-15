class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_filter :authorize

  def index
    @users = User.paginate page: params[:page], per_page: Settings.user.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t ".wel"
      redirect_to @user
    else
      render :new
    end
  end

  def show
    redirect_to(signup_url) unless @user
  end

  def edit
    redirect_to(signup_url) unless @user
  end

  def update
    if @user.update user_params
      flash[:success] = t ".pr_updated"
      redirect_to @user
    else
      flash[:danger] = t ".pl"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".user_deleted"
      redirect_to users_url
    else
      flash[:danger] = t ".pl"
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t ".pl"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  protected

  def authorize
    @user = User.find_by id: params[:id]

    redirect_to login_url, notice: t(".notice") if @user.nil?
  end
end
