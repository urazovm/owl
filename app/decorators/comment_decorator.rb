class CommentDecorator < ApplicationDecorator
  def message
    h.content_tag :p, object.message, class: 'message'
  end

  def delete_link
    h.link_to h.t('.delete'), h.list_comment_path(object.list, object), method: :delete, class: 'delete text-danger' if h.signed_in? && h.current_user.id == object.user_id
  end
end
