class MypagesController < ApplicationController

  def index
    @posts = Post.all.reverse
  end
  
end
