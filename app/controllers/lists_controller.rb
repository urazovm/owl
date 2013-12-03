class ListsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def new
    @list = List.new
    @list.items.build
  end

  def create
    @list = List.new(list_params)
    @list.items.destroy_all(name: '')
    @list.items.each_with_index {|list, i| list.position = i }
    if @list.save
      current_user.lists << @list if signed_in?
      create_tmp_list(@list) unless signed_in?
      redirect_to lists_path
    else
      render :new
    end
  end

  def index
    @tmp_lists = List.where(:_id.in => tmp_lists) if has_tmp_lists?
    @lists = List.search(params, params[:page])
    @query = params[:query] unless params[:query].blank?
    @category_id = params[:category_id] unless params[:category_id].blank?
  end

  def show
    @list = List.find(params[:id])
    @category_id = @list.category_id
    @user = @list.user
    @items = @list.items_ordered
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
    if @list.save
      redirect_to list_path(@list)
    else
      render :edit
    end
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
