class ProfileController < ApplicationController
  before_filter :require_session
  
  def show
    @user = User.find_by_nickname(params[:nickname])
  end
end
