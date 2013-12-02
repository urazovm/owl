class ImagesController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]

  def destroy
    list = List.find(params[:list_id])
    redirect_to lists_path and return unless is_list_owner?(list)
    @item = list.items.find(params[:item_id])
    @item.image.clear
    list.save
    redirect_to list_path(list) unless request.xhr?
  end
end
