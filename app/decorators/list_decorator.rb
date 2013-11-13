class ListDecorator < ApplicationDecorator
  delegate :id

  def title
    object.title.capitalize
  end

  def description
    h.simple_format object.description
  end

  def items
      object.items.decorate
  end

  def comments
      object.comments.decorate
  end

  def linked_title
    h.link_to model.title, h.list_path(model)
  end

  def linked_category
    h.link_to model.category_name, h.lists_path(category_id: model.category_id)
  end

  def edit_link
    h.link_to 'edit', h.edit_list_path(model) if h.signed_in? && model.user_id == h.current_user.id
  end

  def linked_user
    h.link_to model.user.login, h.lists_path
  end

  def love_link
    h.link_to "like", h.list_love_path(object), remote: true, method: :post
  end

  def ignore_link
    h.link_to "dislike", h.list_love_path(object), remote: true, method: :delete
  end

  def total_lovers
    object.lovers.count
  end
end
