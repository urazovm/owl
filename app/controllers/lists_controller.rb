class ListsController < ApplicationController
  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if (@list.save)
      current_user.lists << @list if signed_in?
      create_tmp_list(@list) unless signed_in?
      redirect_to lists_path
    else
      render :new
    end
  end

  def index
    @tmp_lists = List.where(:_id.in => tmp_lists).decorate if has_tmp_lists?
    @lists = List.where(user_id: { '$exists' => true }).decorate
  end

  def show
    @list = List.find(params[:id]).decorate
  end

  def edit
    @list = List.find(params[:id])
    redirect_to lists_path and return unless is_list_owner?(@list)
  end

  def update
    @list = List.find(params[:id])
    redirect_to lists_path and return unless is_list_owner?(@list)
    render :edit and return unless @list.update_attributes(list_params)
    redirect_to list_path(@list)
  end

  def destroy
    list = List.find(params[:id])
    if is_list_owner?(list)
      list.soft_delete
      remove_tmp_list(list)
    end
    redirect_to lists_path
  end

private

  def list_params
    params.require(:list).permit(:title)
  end
end
