class PostsController < ApplicationController
  before_action :set_post, only: %i(show edit update destroy)
  before_action :set_orders, only: %i(show edit update)
  before_action :authenticate_user
  before_action :limit_access, only: %i(edit update destroy)

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(:orders).page(params[:page]).per(12)
  end

  def new
    @post = Post.new
    2.times { @post.orders.build }
  end

  def show; end

  def edit
    @post.orders.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: t('view.flash.post_save')
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: t('view.flash.post_update')
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: t('view.flash.post_delete')
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_orders
    @orders = @post.orders
  end

  def post_params
    params.require(:post).permit(
      :restaurant_name,
      :food_genre,
      :note,
      orders_attributes: %i(recommend_dish reason dish_image dish_image_cash id _destroy),
    )
  end

  def limit_access
    post = Post.find_by(id: params[:id])
    redirect_to posts_path, notice: t('view.flash.limit_access') unless @post.user_id == current_user.id
  end
end
