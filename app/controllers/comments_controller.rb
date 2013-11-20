class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @list = List.find(params[:list_id])
    @comment = @list.comments.new({user: current_user}.merge(comments_params))
    if @list.save && @comment.errors.empty?
      redirect_to list_path(@list) and return unless request.xhr?
      @comments = @list.comments.desc(:created_at)
    else
      render 'lists/show' and return unless request.xhr?
      render :edit
    end
  end

  def destroy
    list = List.find(params[:list_id])
    list.comments.destroy_all(id: params[:id], user_id: current_user.id)
    @comments = list.comments.desc(:created_at)
    redirect_to list_path(list) unless request.xhr?
  end

private

  def comments_params
    params.require(:comment).permit(:message)
  end
end
