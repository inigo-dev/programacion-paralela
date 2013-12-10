class Admin::SharedController < ApplicationController
  layout 'backend'
  
  add_breadcrumb 'home', :admin_root_url
  
  before_filter :require_admin_session

  protected
    def get_current_admin
      @current_admin = Admin.select([:id,:name,:surname]).where(id: session[:admin_id]).first unless session[:admin_id].blank?
    end
  
    def require_admin_session
      get_current_admin
      unless @current_admin
        flash[:warning] = "Por favor inicia sesi&oacute;n"
        redirect_to admin_splash_login_url
      end
    end
end
