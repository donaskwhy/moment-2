class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.name = current_user.name
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

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :name, :user_id, :image)
  end
end
