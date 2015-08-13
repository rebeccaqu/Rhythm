class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    if current_user
      user_path(current_user) || stored_location_for(resource) || root_path
    else
      physician_path(current_physician) || stored_location_for(resource) || root_path
    end
  end

  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)
  end

  def devise_parameter_sanitizer
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    elsif resource_class == Physician
      Physician::ParameterSanitizer.new(Physician, :physician, params)
    else
      super # Use the default one
    end
  end
end
