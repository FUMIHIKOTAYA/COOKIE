class PostsController < ApplicationController
  before_action :set_post, only: %i(show edit update)
  before_action :set_order, only: %i(show edit update)

  def index
  end

  def new
    @post = Post.new
    2.times { @post.orders.build }
  end

  def show
  end

  def edit
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
  end

  def destroy
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
      orders_attributes: %i(recommend_dish reason dish_image dish_image_cash),
    )
  end
end
