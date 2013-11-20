class ListDecorator < ApplicationDecorator
  delegate :id

  def title
    obect.title.capitalize
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

  def date
    object.created_at.to_s(:short)
  end

  def linked_title
    h.link_to model.title.capitalize, h.list_path(model)
  end

  def linked_category
    h.link_to model.category_name, h.lists_path(category_id: model.category_id), class: 'btn btn-default'
  end

  def edit_link
    h.link_to 'edit this list', h.edit_list_path(model), class: 'btn btn-default btn-full' if h.signed_in? && model.user_id == h.current_user.id
  end

  def love_button
    h.render partial: 'loves/button', locals: { list: object } if h.signed_in? && model.user_id != h.current_user.id
  end

  def lovers_link
    h.link_to total_lovers, h.list_loves_path(model), class: 'btn btn-default'
  end

  def comments_link
    h.link_to total_comments, h.list_comments_path(model), class: 'btn btn-default'
  end

  def items_link
    h.link_to total_items, h.list_path(model), class: 'btn btn-default'
  end

  def linked_user
    h.link_to model.user.login, h.user_path(model.user)
  end

  def love_link
    h.link_to "like", h.list_love_path(object), remote: true, method: :post, class: 'btn btn-primary btn-full'
  end

  def ignore_link
    h.link_to "dislike", h.list_love_path(object), remote: true, method: :delete, class: 'btn btn-default btn-full'
  end

  def total_lovers
    h.content_tag :strong, "#{object.lovers.count} ♥", class: 'loves', id: "#total_lovers_#{object.id}"
  end

  def total_comments
    h.content_tag :strong, "#{object.comments.count} c", class: 'comments', id: "#total_comments_#{object.id}"
  end

  def total_items
    h.content_tag :strong, "#{object.items.count} i", class: 'items', id: "#total_items_#{object.id}"
  end
end
