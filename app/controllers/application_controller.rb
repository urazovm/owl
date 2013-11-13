class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  before_filter :configure_devise_params, if: :devise_controller?
  after_filter :store_urlback

  # PERMITIONS
  def is_list_owner? list
    has_tmp_list?(list) || (signed_in? && current_user.id == list.user_id)
  end

  # TMP LISTS
  def create_tmp_list list
    cookies.permanent.signed[:owl_lists] = (cookies.signed[:owl_lists]||[]) << list.id.to_s
  end
  def remove_tmp_list list
    cookies.permanent.signed[:owl_lists] = cookies.signed[:owl_lists].reject! {|e| e == list.id.to_s } if cookies.signed[:owl_lists]
  end
  def tmp_lists
    cookies.signed[:owl_lists] || []
  end
  def has_tmp_list? list
    cookies.signed[:owl_lists] && cookies.signed[:owl_lists].include?(list.id.to_s)
  end
  def has_tmp_lists?
    cookies.signed[:owl_lists] && cookies.signed[:owl_lists].count > 0
  end
  def assign_tmp_lists user
    tmp_lists.each {|id| user.lists << List.find(id) }
  end
  def clear_tmp_lists
    cookies.delete :owl_lists
  end

  # DEVISE
  def after_sign_in_path_for(resource)
    assign_tmp_lists(resource)
    clear_tmp_lists
    session[:stored_url] ? session[:stored_url] : lists_path
  end
  def after_sign_out_path_for(resource)
    session[:stored_url] ? session[:stored_url] : lists_path
  end

  # GLOBAL
  def store_urlback
    session[:stored_url] = params[:r] ? params[:r] : nil
  end

  # DEVISE
  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:login, :email, :password, :password_confirmation) }
  end
end
