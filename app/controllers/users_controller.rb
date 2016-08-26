class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Välkommen! Du är nu registerad.'
      # Redirect to users page.
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profil uppdaterad!'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'Användare raderad!'
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user)
          .permit(:name, :email, :password, :password_confirmation)
  end

  # Before filters

  # Confirms logged-in user.
  def logged_in_user
    unless logged_in?
      # Using session helper method store_location to store
      # requested url to allow friendly forwarding.
      store_location
      flash[:danger] = 'Vänligen logga in.'
      redirect_to login_url
    end
  end

  # Confirms correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
