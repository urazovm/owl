class ListsController < ApplicationController
  def new
    @list = List.new
    @list.items.build
  end

  def create
    @list = List.new(list_params)
    @list.items.destroy_all(name: '')
    @list.items.each_with_index {|list, i| list.position = i }
    render :new and return unless @list.save
    current_user.lists << @list if signed_in?
    create_tmp_list(@list) unless signed_in?
    redirect_to lists_path
  end

  def index
    @tmp_lists = List.where(:_id.in => tmp_lists).decorate if has_tmp_lists?
    @lists = List.search(params, params[:page])
  end

  def show
    list = List.find(params[:id])
    @list = list.decorate
    @comments = list.comments.desc(:created_at).includes(:user).decorate
    @comment = list.comments.build if signed_in?
  end

  def edit
    @list = List.find(params[:id])
    @list.items.build
    redirect_to lists_path and return unless is_list_owner?(@list)
  end

  def update
    @list = List.find(params[:id])
    redirect_to lists_path and return unless is_list_owner?(@list)
    @list.assign_attributes(list_params)
    @list.items.destroy_all(name: '')
    @list.items.each_with_index {|list, i| list.position = i }
    redirect_to list_path(@list) and return if @list.save
    render :edit
  end

  def destroy
    list = List.find(params[:id])
    redirect_to lists_path and return unless is_list_owner?(list)
    list.soft_delete
    remove_tmp_list(list)
  end

private

  def list_params
    params.require(:list).permit(:title, :category_id, :description, items_attributes: [:name, :id, :image])
  end
end
