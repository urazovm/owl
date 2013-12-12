class ListsController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :destroy]

  def new
    list = List.find_or_create_by(completed: false, user_id: current_user.id)
    redirect_to edit_list_path(id: list.id.to_s), status: :found
  end

  def index
    @tmp_lists = List.where(:_id.in => tmp_lists) if has_tmp_lists?
    @lists = List.search(params, params[:page])
    @query = params[:query] unless params[:query].blank?
    @category_id = params[:category_id] unless params[:category_id].blank?
  end

  def show
    @list = List.find(params[:id])
    @comments = @list.comments.where(:created_at.exists => true).desc(:created_at).includes(:user)
    @comment = @list.comments.build
    @category_id = @list.category_id
    @user = @list.user
    @items = @list.items_ordered
  end

  def edit
    @list = List.unscoped.find(params[:id])
    redirect_to home_path and return unless is_list_owner?(@list)
  end

  def update
    @list = List.unscoped.find(params[:id])
    redirect_to home_path and return unless is_list_owner?(@list)
    @list.assign_attributes(list_params)
    @list.items.each_with_index {|list, i| list.position = i }
    if @list.save
      redirect_to list_path(@list)
    else
      render :edit
    end
  end

  def destroy
    list = List.find(params[:id])
    redirect_to home_path and return unless is_list_owner?(list)
    list.soft_delete
    remove_tmp_list(list)
  end

private

  def list_params
    params.require(:list).permit(:title, :category_id, items_attributes: [:id, :type, :name, :text, :link, :image])
  end
end
