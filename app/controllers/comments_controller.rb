class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @list = List.find(params[:list_id])
    @comment = @list.comments.create({user: current_user}.merge(comments_params))
    if request.xhr?
      render :edit and return unless @comment.errors.empty?
      @comments = @list.comments.desc(:created_at).decorate
    else
      redirect_to list_path(@list) and return if @comment.errors.empty?
      @list = list.decorate
      render 'lists/show'
    end
  end

  def destroy
    list = List.find(params[:list_id])
    list.comments.destroy_all(id: params[:id], user_id: current_user.id)
    @comments = list.comments.desc(:created_at).decorate
    redirect_to list_path(list) unless request.xhr?
  end

private

  def comments_params
    params.require(:comment).permit(:message)
  end
end
