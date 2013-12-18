class Admin::AdminsController < Admin::SharedController
  add_breadcrumb 'administradores', :admin_admins_url 
  
    def index
    @admins = Admin.order(:name).page(params[:page])
    
    respond_to do |format|
      format.html
      format.json { render json: @admins }
    end
  end
  
  def new
    @admin = Admin.new
    add_breadcrumb 'agregar', new_admin_admin_url
  end
  
  def show
    @admin = Admin.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render json: @admin }
    end
  end
  
  def create
    @admin = Admin.new(admin_params)
    
    respond_to do |format|
      if @admin.save
        format.html { redirect_to admin_admins_url, notice: 'El administrador se ha agregado' }
        format.json { render json: @admin, status: :created, location: admin_admin_url(@admin) }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
    
  end 
  
  def edit
    @admin = Admin.find(params[:id])    
    add_breadcrumb 'editar', edit_admin_admin_url(@admin)
  end
  
  def update
    @admin = Admin.find(params[:id])
    
    respond_to do |format|
      if @admin.update_attributes(admin_params)
        format.html { redirect_to admin_admins_url, notice: 'El administrador se ha actualizado' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
    
  end
  
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy 
    
    respond_to do |format|
      format.html { redirect_to admin_admins_url, notice: 'El material se ha eliminado' }
      format.json { head :no_content }
    end
  end

  params_for :admin, :name, :surname, :email, :password, :password_confirmation
end
