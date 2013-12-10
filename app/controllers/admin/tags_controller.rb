class Admin::TagsController < Admin::SharedController
  add_breadcrumb 'tags', :admin_tags_url 
  
  def index
    @tags = Tag.order(:name).page(params[:page])
    
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end
  
  def edit
    @tag = Tag.find(params[:id])
    add_breadcrumb 'Editar', edit_admin_tag_url(@tag)
  end
  
  def update
    @tag = Tag.find(params[:id])
    
    respond_to do |format|
      if @tag.update_attributes(tag_params)
        format.html { redirect_to admin_tags_url, notice: 'El tag se ha actualizado' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
    
  end
  
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy 
    
    respond_to do |format|
      format.html { redirect_to admin_tags_url, notice: 'El tag se ha eliminado' }
      format.json { head :no_content }
    end
  end
  
  params_for :tag, :name, :featured
end
