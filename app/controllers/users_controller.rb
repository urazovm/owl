class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tmp_lists = List.where(:_id.in => tmp_lists) if has_tmp_lists?
    @lists = List.search({user_id: params}, params[:page])
  end

private

  def user_params
    params.require(:user).permit(:avatar)
  end
end
