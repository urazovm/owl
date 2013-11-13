class FollowingsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @users = User.where(:id.in => user.followings).decorate
    @user = user.decorate
  end
end
