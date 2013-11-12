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
    @tmp_lists = List.where(:_id.in => tmp_lists) if has_tmp_lists?
    @lists = List.where(user_id: { '$exists' => true })
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

private

  def list_params
    params.require(:list).permit(:title)
  end
end
