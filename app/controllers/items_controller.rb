class ItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :accpet_xhr_requests_only!

  def create
    @list = List.unscoped.find(params[:list_id])
    render inline: '0' and return unless is_list_owner?(@list)
    @item = @list.items.create(type: params[:type])
  end

  def edit
    list = List.unscoped.find(params[:list_id])
    render inline: '0' and return unless is_list_owner?(list)
    @item = list.items.find(params[:id])
  end

  def update
    list = List.unscoped.find(params[:list_id])
    render inline: '0' and return unless is_list_owner?(list)
    @item = list.items.find(params[:id])
    @item.assign_attributes(item_params)
    @item.save
  end

  def destroy
    list = List.unscoped.find(params[:list_id])
    render inline: '0' and return unless is_list_owner?(list)
    @item = list.items.find(params[:id])
    @item.destroy
  end

private

  def item_params
    params.require(:item).permit(:type, :name, :text, :link, :image)
  end
end
