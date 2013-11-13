class CommentsController < ApplicationController
  before_filter :require_session 
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = @current_user.id
    
    if @comment.save
      redirect_to post_url(@post), notice: 'El comentario se ha agregado'
    else
      flash[:warning] = 'Ups algo salio mal'
      redirect_to post_url(@post)
    end
  end
  params_for :comment, :text
end
