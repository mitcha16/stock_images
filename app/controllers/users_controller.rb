class UsersController < ApplicationController
  before_action :logged_in, only: [:index, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @images = @user.images
  end

  def save
    @user = current_user
    @user.images << Image.create(url: params[:url])
  end

  def remove
    image = Image.find_by(url: params[:url])
    image.delete
    flash[:success] = "Image Deleted!"
    redirect_to user_path(User.find(params[:user_id]))
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Thanks for signing up!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your account has been updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
    :password_confirmation)
  end

  def authorized
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
