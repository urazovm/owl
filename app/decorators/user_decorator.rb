class UserDecorator < ApplicationDecorator
  def login
    object.login
  end

  def linked_login
    h.link_to model.login, h.user_path(model)
  end

  def avatar_image style
    h.image_tag object.avatar.url(style)
  end

  def linked_avatar_image style
    h.link_to avatar_image(style), h.user_path(model)
  end

  def edit_link
    h.link_to 'edit', h.edit_user_registration_path(r: 1) if h.signed_in? && h.current_user.id == object.id
  end

  def follow_button
    h.render partial: 'follows/button', locals: { user: object } if h.signed_in? && h.current_user.id != object.id
  end

  def lovings_link
    h.link_to 'lovings', h.user_loves_path(model)
  end

  def followings_link
    h.link_to 'followings', h.user_followings_path(model)
  end

  def followers_link
    h.link_to 'followers', h.user_followers_path(model)
  end

  def follow_link
    h.link_to "follow", h.user_follow_path(object), remote: true, method: :post
  end

  def unfollow_link
    h.link_to "unfollow", h.user_follow_path(object), remote: true, method: :delete
  end

  def total_loves
    h.content_tag :strong, h.t('love', count: object.total_loves), class: 'loves', id: "total_loves_#{object.id}"
  end

  def total_followings
    h.content_tag :strong, h.t('following', count: object.followings.count), class: 'followings', id: "total_followings_#{object.id}"
  end

  def total_followers
    h.content_tag :strong, h.t('follower', count: object.followers.count), class: 'followers', id: "total_followers_#{object.id}"
  end

  def total_lists
    h.content_tag :strong, h.t('list', count: object.lists.count), class: 'lists', id: "total_lists_#{object.id}"
  end
end
