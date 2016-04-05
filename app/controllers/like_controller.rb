class LikeController < ApplicationController
  before_action :find_likeable
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  
  def create
      @likeable.liked_by current_user
    end

  def destroy
      @likeable.disliked_by current_user
    end

private
    def find_likeable
      @likeable_type = params[:likeable_type].classify
      @likeable = @likeable_type.constantize.find(params[:likeable_id])
    end
  end
