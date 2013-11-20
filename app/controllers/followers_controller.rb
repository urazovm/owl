class FollowersController < ApplicationController
  def index
    @user = (signed_in? && current_user.slug == params[:user_id]) ? current_user : User.find(params[:user_id])
    @users = User.where(:id.in => @user.followers)
    logger.debug @user.followers
  end
end
