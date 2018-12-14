class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def create
    comment = Comment.new
    comment.content = params[:content]
    comment.user_id = current_user.id
    comment.post_id = params[:post_id]
    if comment.save
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    comment.destroy
  end
end
