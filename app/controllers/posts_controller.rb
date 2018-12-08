class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_name = current_user.user_name
    @post.user_id = current_user.id
    @post.save

    redirect_to '/posts/'
  end

  def update
     @post.update(post_params)

     redirect_to '/posts/'
  end

  def destroy
    @post.destroy

    redirect_to '/posts/'
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :name)
  end
end
