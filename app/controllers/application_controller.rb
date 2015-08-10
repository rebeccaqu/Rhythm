class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    user_path(current_user) || stored_location_for(resource) || root_path
  end

  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end
end
