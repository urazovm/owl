class UsersController < ApplicationController
  # caches_action :show

  def show
    user = User.find(params[:id])
    @tmp_lists = List.where(:_id.in => tmp_lists).decorate if has_tmp_lists?
    @lists = List.search({user_id: params}, params[:page])
    @user = user.decorate
  end

private

  def user_params
    params.require(:user).permit(:avatar)
  end
end
