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
    if params[:list_id].present?
      list = List.find(params[:list_id])
      @users = User.where(:id.in => list.lovers).decorate
      @list = list.decorate
    elsif params[:user_id].present?
      user = User.find(params[:user_id])
      @lists = List.where(:id.in => user.lovings).decorate
      @user = user.decorate
    end
  end
end
