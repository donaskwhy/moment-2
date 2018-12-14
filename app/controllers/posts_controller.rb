class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_name = current_user.name
    @post.user_id = current_user.id
    @post.save

    redirect_to "/mypages/#{current_user.id}"
  end

  def update
     @post.update(post_params)

    redirect_to "/mypages/#{current_user.id}"
  end

  def destroy
    @post.destroy

    redirect_to "/mypages/#{current_user.id}"
  end

  def comments
    @post = Post.find(params[:id])
    @post.comments.create(content: params[:content])
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :name, :user_id, :image)
  end
end
