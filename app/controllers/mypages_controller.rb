class MypagesController < ApplicationController

  def show
    @posts = Post.all.reverse
    @user = User.find(params[:id])
  end

end
