class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_current_user
  require 'params_for'
  extend ParamsFor
  
  protected
    
    def get_current_user
      @current_user = User.find(session[:user_id]) unless session[:user_id].blank?
    end
    
    def require_session
      redirect_to root_url, notice: 'Por favor inicia sesi&oacute;n' if @current_user.nil?
    end
end
