class AccountsController < ApplicationController
  before_filter :require_session
  def destroy
    @account = @current_user.accounts.find_by_provider(params[:provider])  
    @account.destroy if @account
    redirect_to profile_information_url(nickname: @current_user.nickname)
  end
end
