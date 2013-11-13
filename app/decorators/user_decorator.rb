class UserDecorator < ApplicationDecorator
  def login
    object.login
  end

  def linked_login
    h.link_to model.login, h.user_path(model)
  end

  def edit_link
    h.link_to 'edit', h.edit_user_registration_path(object) if h.signed_in? && h.current_user.id == object.id
  end

  def lovings_link
    h.link_to 'lovings', h.user_loves_path(model)
  end
end
