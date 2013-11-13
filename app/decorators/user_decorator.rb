class UserDecorator < ApplicationDecorator
  def login
    object.login.capitalize
  end

  def edit_link
    h.link_to 'edit', h.edit_user_registration_path(object) if h.signed_in? && h.current_user.id == object.id
  end
end
