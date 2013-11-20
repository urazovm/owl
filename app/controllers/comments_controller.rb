class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @list = List.find(params[:list_id])
    @comment = @list.comments.new({user: current_user}.merge(comments_params))
    if @list.save && @comment.errors.empty?
      redirect_to list_comments_path(@list) and return unless request.xhr?
      @comments = @list.comments.desc(:created_at)
    else
      render 'comments/index' and return unless request.xhr?
      render :edit
    end
  end

  def destroy
    list = List.find(params[:list_id])
    list.comments.destroy_all(id: params[:id], user_id: current_user.id)
    @comments = list.comments.desc(:created_at)
    redirect_to list_path(list) unless request.xhr?
  end

  def index
    @list = List.find(params[:list_id])
    @comments = @list.comments.desc(:created_at).includes(:user)
    @comment = @list.comments.build if signed_in?
    @category_id = @list.category_id
    @user = @list.user
  end

private

  def comments_params
    params.require(:comment).permit(:message)
  end
end
