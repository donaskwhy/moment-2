class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def create
    comment = Comment.new
    comment.content = params[:content]
    comment.post_id = params[:post_id]
    comment.save
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    comment.destroy
  end
end
