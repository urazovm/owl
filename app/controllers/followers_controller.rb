class FollowersController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @users = User.where(:id.in => user.followers).decorate
    @user = user.decorate
  end
end
