class ListDecorator < ApplicationDecorator
  delegate :id

  def title
    (object.title||'').capitalize
  end

  def comments
    object.comments.decorate
  end

  def date
    object.created_at.to_s(:short)
  end

  def linked_title
    h.link_to model.display_title.capitalize, h.list_path(model)
  end

  def category
    model.category_name
  end

  def linked_category
    h.link_to model.category_name, h.home_path(category_id: model.category_id)
  end

  def edit_button
    if model.user.blank?
      h.link_to h.t('.edit'), h.edit_list_path(model), class: 'edit_button' if h.has_tmp_list? object
    else
      h.link_to h.t('.edit'), h.edit_list_path(model), class: 'edit_button hidden', 'data-user' => object.user.id.to_s
    end
  end

  def report_button
    if model.user.blank?
      h.link_to h.t('.report'), '#', remote: false, class: 'report_button text-danger', 'data-list' => object.id.to_s
    else
      h.link_to h.t('.report'), '#', remote: false, class: 'report_button text-danger', 'data-list' => object.id.to_s, 'data-user' => object.user.id.to_s
    end
  end

  def love_button
    h.render partial: 'loves/button', locals: { list: self }
  end

  def lovers_link
    h.link_to total_lovers, h.list_loves_path(model), remote: true, class: 'lovers'
  end

  def comments_link
    h.link_to total_comments_named, h.list_comments_path(model), remote: true, class: 'comments'
  end

  def linked_user
    return if model.user.blank?
    user = model.user.decorate
    user.linked_avatar_image(:small) + \
    user.linked_login
  end

  def user_linked_avatar_image(style)
    return if model.user.blank?
    model.user.decorate.linked_avatar_image(style)
  end

  def user_linked_login
    return if model.user.blank?
    model.user.decorate.linked_login
  end

  def love_link
    h.link_to h.t('.love'), h.list_love_path(object), remote: true, method: :post, class: 'btn btn-primary btn-full love'
  end

  def ignore_link
    h.link_to h.t('.ignore'), h.list_love_path(object), remote: true, method: :delete, class: 'btn btn-default btn-full ignore'
  end

  def total_lovers_named
    h.content_tag :span, h.t('lover_html', count: object.lovers.count), class: "total_lovers_#{object.id}"
  end

  def total_comments_named
    h.content_tag :span, h.t('comment_html', count: object.comments.count), class: "total_comments_#{object.id}"
  end

  def total_items_named
    h.content_tag :span, h.t('item_html', count: object.items.count), class: "total_items_#{object.id}"
  end

  def total_lovers
    h.content_tag :span, h.content_tag(:strong, object.lovers.count), class: "total_lovers_#{object.id}"
  end

  def total_comments
    h.content_tag h.content_tag(:strong, object.comments.where(:created_at.exists => true).count), class: "total_comments_#{object.id}"
  end
end
