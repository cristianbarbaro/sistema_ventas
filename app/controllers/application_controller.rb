class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_return_to_previous_url, only: [:show, :edit, :index]
  protect_from_forgery with: :exception
  helper_method :sort_column, :sort_direction

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def authorized_admin
    return unless !current_user.admin?
    redirect_to root_path, alert: '¡Solo se permite el acceso a usuarios administradores!'
  end

  def set_return_to_previous_url
    session[:return_to] = request.referer
  end

  def return_to_previous_url
    session.delete(:return_to)
  end
end
