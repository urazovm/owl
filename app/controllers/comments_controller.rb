class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @list = List.find(params[:list_id])
    @comment = @list.comments.create({user: current_user}.merge(comments_params))
    if @comment.errors.empty?
      # expire_action list_path(@list)
      render :edit and return if request.xhr?
      redirect_to list_path(@list)
    else
      if request.xhr?
        @comments = @list.comments.desc(:created_at).decorate
      else
        @list = list.decorate
        render 'lists/show'
      end
    end
  end

  def destroy
    list = List.find(params[:list_id])
    list.comments.destroy_all(id: params[:id], user_id: current_user.id)
    @comments = list.comments.desc(:created_at).decorate
    # expire_action list_path(list)
    redirect_to list_path(list) unless request.xhr?
  end

private

  def comments_params
    params.require(:comment).permit(:message)
  end
end
