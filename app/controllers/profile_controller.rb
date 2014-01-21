class ProfileController < ApplicationController
  before_filter :find_user_by_nickname, except: :update
  before_filter :require_session, only: :update
  
  def show
    Rails.logger.info "[INFO] Current id: #{@current_user.id}"
    Rails.logger.info "[INFO] Profile id: #{@user.id}"
  end
  
  def channels
    @channels = Tag.order(:name).page(params[:page]).per_page(20)
  end
  
  def information
  
  end
  
  def update
    if @current_user.update_attributes(user_params)
      redirect_to profile_information_url(nickname: @current_user.nickname), notice: 'Tu informaci&oacute;n se ha actualizado'
    else
      @user = @current_user
      @show_form = true
      render 'information'
    end
  end
  
  params_for :user, :name, :surname, :email
  
  protected
  
    def find_user_by_nickname
      @user = User.find_by_nickname(params[:nickname])
    end
end
