class SessionsController < ApplicationController
  def create
    if session[:user_id]
      @user = User.find(session[:user_id])
      @user.add_account(auth_hash)
    else
      @account = Account.find_or_create_from_auth_hash(auth_hash)
      session[:user_id] = @account.user_id    
      @user = @account.user
    end
    redirect_to profile_url(@user.nickname)
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
