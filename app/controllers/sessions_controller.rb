class SessionsController < ApplicationController

  def new
    session[:social_redirect_url] = params[:url]
    redirect_to "/auth/#{params[:provider]}"
  end
  
  def create
    if session[:user_id]
      @user = User.find(session[:user_id])
      @user.add_account(auth_hash)
    else
      @account = Account.find_or_create_from_auth_hash(auth_hash)
      session[:user_id] = @account.user_id    
      @user = @account.user
    end
    
    if session[:social_redirect_url]
      redirect_url, session[:social_redirect_url] = session[:social_redirect_url], nil
      redirect_to redirect_url
    else
      redirect_to profile_url(@user.nickname)    
    end
  end
  
  def failure
    
  end
  
  def destroy
    reset_session
    redirect_to root_url
  end
  
  protected
    def auth_hash
      request.env["omniauth.auth"]
    end
end
