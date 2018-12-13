class MypagesController < ApplicationController

  def show
    @posts = Post.where(user: params[:id]).reverse
    @user = User.find(params[:id])
  end

end
