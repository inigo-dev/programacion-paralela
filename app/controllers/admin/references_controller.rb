class Admin::ReferencesController < Admin::SharedController
  add_breadcrumb 'referencias', :admin_references_url 
  
  before_filter :get_reference_types, only: [:new,:edit]
  
  def index
    @references = Reference.includes(:reference_type).order(:title).page(params[:page])
    
    respond_to do |format|
      format.html
      format.json { render json: @references }
    end
  end
  
  def new
    @reference = Reference.new
    store_reference
    add_breadcrumb 'agregar', new_admin_reference_url
  end
  
  def show
    @reference = Reference.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render json: @reference }
    end
  end
  
  def create
    @reference = Reference.new(reference_params)
    
    respond_to do |format|
      if @reference.save
        format.html { redirect_to admin_references_url, notice: 'El material se ha agregado' }
        format.json { render json: @reference, status: :created, location: admin_reference_url(@reference) }
      else
        store_reference
        get_reference_types
        format.html { render action: 'new' }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
    
  end 
  
  def edit
    @reference = Reference.find(params[:id])
    store_reference
    add_breadcrumb 'editar', edit_admin_reference_url(@reference)
  end
  
  def update
    @reference = Reference.find(params[:id])
    
    respond_to do |format|
      if @reference.update_attributes(reference_params)
        format.html { redirect_to admin_references_url, notice: 'El material se ha actualizado' }
        format.json { head :no_content }
      else
        store_reference
        get_reference_types
        format.html { render action: "edit" }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
    
  end
  
  def destroy
    @reference = Reference.find(params[:id])
    @reference.destroy 
    
    respond_to do |format|
      format.html { redirect_to admin_references_url, notice: 'El material se ha eliminado' }
      format.json { head :no_content }
    end
  end
  
  params_for :reference, :title, :url, :reference_type_id, :image, :description, :tag_values
  
  protected
    def get_reference_types
      @reference_types = ReferenceType.order(:name)
    end
    
    def store_reference
      gon.reference = @reference.as_json(methods: :tag_values)
    end
    
    
  
  
end
