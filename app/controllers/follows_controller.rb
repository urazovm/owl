class FollowsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    current_user.follow! @user
    # expire_action user_path(@user)
    # expire_action user_path(current_user)
    # expire_action followers_path(@user)
    # expire_action followings_path(current_user)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow! @user
    # expire_action user_path(@user)
    # expire_action user_path(current_user)
    # expire_action followers_path(@user)
    # expire_action followings_path(current_user)
  end
end
