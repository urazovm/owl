class UserDecorator < ApplicationDecorator
  def login
    object.login.capitalize
  end
end
