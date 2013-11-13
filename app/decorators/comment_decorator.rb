class CommentDecorator < ApplicationDecorator
  def message
    h.content_tag :p, object.message, class: 'message'
  end

  def delete_link
    h.link_to 'delete', h.list_comment_path(object.list, object), method: :delete, remote: true if h.signed_in? && h.current_user.id.to_s == object.user_id
  end

  def linked_user
    h.link_to model.user.login, h.lists_path
  end
end
