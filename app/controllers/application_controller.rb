class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  protect_from_forgery with: :exception

  before_action :configure_permited_parameters, if: :devise_controller?

  def authenticate_admin!
    if current_user.nil?
      if !current_user.admin
        redirect_to new_user_session_path
      end
    end
  end

  protected

  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :pic_url, :admin])
  end

end
