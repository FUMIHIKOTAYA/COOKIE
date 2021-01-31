class PostsController < ApplicationController
  before_action :set_post, only: %i(show edit update destroy)
  before_action :set_orders, only: %i(show edit update)

  def index
    @posts = Post.all.includes(:orders)
  end

  def new
    @post = Post.new
    @post.orders.build
  end

  def show; end

  def edit
    @post.orders.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, notice: '記事を投稿しました。'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: '記事を編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: '記事を削除しました。'
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
end
