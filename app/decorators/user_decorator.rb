class UserDecorator < ApplicationDecorator
  def login
    object.login
  end

  def linked_login
    h.link_to model.login, h.user_path(model), class: :login
  end

  def avatar_image style
    h.image_lazy_tag object.avatar.url(style), class: "avatar avatar-#{style}"
  end

  def linked_avatar_image style
    h.link_to avatar_image(style), h.user_path(model)
  end

  def logout_link
    h.link_to 'logout', h.destroy_user_session_path(r: 1), method: :delete, class: 'btn btn-default hidden logout'
  end

  def edit_link
    h.link_to h.content_tag(:i, '', class: 'fa fa-cog'), h.edit_user_registration_path(r: 1), class: 'btn btn-default hidden edit'
  end

  def follow_button
    h.content_tag(:div, class: 'follow_button', 'data-user' => object.id.to_s) do
        h.link_to("follow", h.user_follow_path(object), remote: true, method: :post, class: 'btn btn-primary follow') + \
        h.link_to("unfollow", h.user_follow_path(object), remote: true, method: :delete, class: 'btn btn-default unfollow')
    end
  end

  def lovings_link content
    h.link_to content, h.user_loves_path(model), class: 'btn btn-default lovings'
  end

  def followings_link content
    h.link_to content, h.user_followings_path(model), class: 'btn btn-default followings'
  end

  def followers_link content
    h.link_to content, h.user_followers_path(model), class: 'btn btn-default followers'
  end

  def lists_link content
    h.link_to content, h.user_path(model), class: 'btn btn-default lists'
  end

  def total_loves
    h.content_tag :span, object.total_loves, class: "loves total_loves_#{object.id}"
  end

  def total_lovings
    h.content_tag :span, h.t('loving_html', count: object.total_lovings), class: "lovings total_lovings_#{object.id}"
  end

  def total_followings
    h.content_tag :span, h.t('following_html', count: object.followings.count), class: "followings total_followings_#{object.id}"
  end

  def total_followers
    h.content_tag :span, h.t('follower_html', count: object.followers.count), class: "followers total_followers_#{object.id}"
  end

  def total_lists
    h.content_tag :span, h.t('list_html', count: object.lists.count), class: "lists total_lists_#{object.id}"
  end
end
