class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]

  def create
    @list = List.find(params[:list_id])
    @comment = @list.comments.new({user: current_user}.merge(comments_params))
    @comment = @list.comments.build if @list.save && @comment.errors.empty?
    @comments = @list.comments.where(:created_at.exists => true).desc(:created_at).includes(:user)
    render :index
  end

  def destroy
    list = List.find(params[:list_id])
    list.comments.destroy_all(id: params[:id], user_id: current_user.id)
    index and render :index
  end

  def index
    list = List.find(params[:list_id])
    @comments = list.comments.where(:created_at.exists => true).desc(:created_at).includes(:user)
    @comment = list.comments.build
  end

private

  def comments_params
    params.require(:comment).permit(:message)
  end
end
