class SubscriptionsController < ApplicationController
  before_filter :require_session

  def create
    @subscription = @current_user.subscriptions.create!(subscription_params)    
    
    respond_to do |format|
      format.html { redirect_to profile_channels_url(nickname: @current_user.nickname) }
      format.js
    end
  end
  
  def destroy
    @subscription = @current_user.subscriptions.find_by_tag_id(params[:tag_id])
    @subscription.destroy
  
    respond_to do |format|
      format.html { redirect_to profile_channels_url(nickname: @current_user.nickname) }
      format.js
    end
  end
  
  params_for :subscription, :tag_id
end
