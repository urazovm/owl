class ItemsController < ApplicationController
  before_filter :authenticate_user!

  def new
    redirect_to home_path unless request.xhr?
    @list = List.unscoped.find(params[:list_id])
    render inline: '0' and return unless is_list_owner?(@list)
    @item = @list.items.create(type: params[:type])
  end

  def destroy
    redirect_to home_path unless request.xhr?
    list = List.unscoped.find(params[:list_id])
    render inline: '0' and return unless is_list_owner?(list)
    @item = list.items.find(params[:id])
    @item.destroy
  end
end