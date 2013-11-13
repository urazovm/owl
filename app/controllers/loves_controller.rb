class LovesController < ApplicationController
  before_filter :authenticate_user!

  def create
    list = List.find(params[:list_id])
    current_user.love! list
    @list = list.decorate
  end

  def destroy
    list = List.find(params[:list_id])
    current_user.ignore! list
    @list = list.decorate
  end

  def index
  end
end

