class ListDecorator < ApplicationDecorator
  delegate :title

  def linked_title
    h.link_to model.title, h.list_path(model)
  end

  def edit_link
    h.link_to 'edit', h.edit_list_path(model) if h.signed_in? && model.user_id == h.current_user.id
  end
end
