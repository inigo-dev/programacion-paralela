class PostsController < ApplicationController
  before_filter :require_session, except: :show

  
  def new
    @post = @current_user.posts.build
    store_post
  end
  
  def create
    @post = @current_user.posts.build(post_params)
    store_post
    
    if @post.save
      redirect_to post_url(@post)
    else    
      render 'new'
    end
  end
  
  def edit
    @post = @current_user.posts.find(params[:id])
    store_post
  end
  
  def update
    @post = @current_user.posts.find(params[:id])
    @post.attributes = post_params
    store_post
    
    if @post.save
      redirect_to post_url(@post)
    else
      render 'edit'
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  params_for :post, :title, :content, :tag_values
  
  protected
    def store_post
      gon.post = @post.as_json(methods: :tag_values)
    end
end
