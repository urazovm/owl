class ListsController < ApplicationController
  def new
    @list = List.new
    @list.items.build
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
    @lists = List.where(user_id: { '$exists' => true })
    @lists = @lists.where(category_id: params[:category_id]) if params[:category_id].present?
    @lists = @lists.decorate
  end

  def show
    @list = List.find(params[:id]).decorate
  end

  def edit
    @list = List.find(params[:id])
    @list.items.build
    redirect_to lists_path and return unless is_list_owner?(@list)
  end

  def update
    @list = List.find(params[:id])
    redirect_to lists_path and return unless is_list_owner?(@list)
    if @list.update_attributes(list_params)
        @list.items.destroy_all(name: '')
        redirect_to list_path(@list)
    else
        render :edit
    end
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
    params.require(:list).permit(:title, :category_id, :description, items_attributes: [:name, :id])
  end
end
