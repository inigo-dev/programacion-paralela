class SplashController < ApplicationController

  def index
    @posts = Post.approved.latest    
  end
end
