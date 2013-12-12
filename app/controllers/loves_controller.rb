class LovesController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]

  def create
    @list = List.find(params[:list_id])
    current_user.love! @list
  end

  def destroy
    @list = List.find(params[:list_id])
    current_user.ignore! @list
  end

  def index
    if params[:list_id].present?
      redirect_to home_path unless request.xhr?
      list = List.find(params[:list_id])
      @users = User.where(:id.in => list.lovers)
    elsif params[:user_id].present?
      @user = User.find(params[:user_id])
      @lists = List.where(:id.in => @user.lovings)
    end
  end
end
