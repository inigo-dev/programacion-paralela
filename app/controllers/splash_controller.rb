class SplashController < ApplicationController

  def index
    @posts = Post.approved.includes(:tags, :comments).latest.page(params[:page])
    @channels = Tag.featured.includes(:users, :posts)    
  end
  
  def search
    @query = params[:query]
    @posts = Post.approved.includes(:tags, :comments).search(@query).page(params[:page])
    @channels = Tag.search(@query).includes(:users, :posts)
  end
  
  def feed
    if @current_user    
      @posts = @current_user.feed_posts.page(params[:page])
    end
  end
end
