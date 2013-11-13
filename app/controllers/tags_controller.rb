class TagsController < ApplicationController

  def index
    @tags = Tag.pluck(:name)
    
    respond_to do |format|
      format.json { render json: @tags }
    end
  end
end
