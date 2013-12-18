class Admin::PostsController < Admin::SharedController
  
  add_breadcrumb 'posts', :admin_posts_url

  def index
    @posts = Post.includes(:user, :tags).order("status", "created_at DESC").page(params[:page])
    
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end
  
  def show
    @post = Post.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy 
    
    respond_to do |format|
      format.html { redirect_to admin_posts_url, notice: 'El post se ha eliminado' }
      format.json { head :no_content }
    end
  end
  
  def reject
    @post = Post.find(params[:id])
    @post.reject!
    
    respond_to do |format|
      format.html { redirect_to admin_post_url(@post), notice: 'El post ha sido rechazado' }
    end
  end
  
  def approve
    @post = Post.find(params[:id])
    @post.approve!
    
    respond_to do |format|
      format.html { redirect_to admin_post_url(@post), notice: 'El post ha sido aprobado' }
    end 
    
  end
  
  
  def approve_multiple
    @posts = Post.where("id IN (?)", params[:ids])
    @posts.approve!
    
    respond_to do |format|
      format.html { redirect_to admin_posts_url, notice: 'Los posts han sido aprobados' }
    end 
  end  
  
  def reject_multiple
    @posts = Post.where("id IN (?)", params[:ids])
    @posts.reject!
    
    respond_to do |format|
      format.html { redirect_to admin_posts_url, notice: 'Los posts han sido rechazados' }
    end 
  end
  

end
