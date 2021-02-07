class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update)
  before_action :authenticate_user, only: %i(show edit)
  before_action :logged_user, only: %i(new)
  before_action :limit_access, only: %i(edit update)

  def show
    @posts = @user.posts.includes(:orders)
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: t('view.flash.user_create')
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: t('view.flash.user_update')
    else
      render :edit
    end
  end

  def follow
    @user = User.find(params[:id])
    if @user == current_user
      @following_users = @user.following
      @followers_users = @user.followers
      render 'show_follow'
    else
      redirect_to user_path(current_user.id), notice: t('view.flash.inaccessible')
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :profile, :profile_image, :profile_image_cache)
  end

  def limit_access
    redirect_to user_path, notice: t('view.flash.limit_access') unless current_user.id == params[:id].to_i
  end
end
