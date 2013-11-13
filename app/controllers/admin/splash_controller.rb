class Admin::SplashController < ApplicationController

  def login
    
  end
  
  def logout
    session[:admin_id] = nil
    redirect_to root_url, notice: 'Tu sesi&oacute;n ha terminado'
  end
  
  def authenticate
    @admin = Admin.authenticate(params[:login][:email], params[:login][:password])
    
    if @admin
      session[:admin_id] = @admin.id
      redirect_to admin_posts_url
    else
      redirect_to admin_splash_login_url, alert: 'Usuario / Contrase&ntilde;a inv&aacute;lidos'
    end
  end
end
