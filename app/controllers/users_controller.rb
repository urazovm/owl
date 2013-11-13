class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @lists = user.lists.decorate
    @user = user.decorate
    @tmp_lists = List.where(:_id.in => tmp_lists).decorate if has_tmp_lists?
  end
end
