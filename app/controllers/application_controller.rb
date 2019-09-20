class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:signup, keys: [:stripe_card_token, :email, :password, :password_confirmation, :login_count])
  end

  private

  def after_sign_in_path_for(resource)
    if current_user.login_count == 0
      new_user_profile_path(user_id: current_user.id)
    else
      root_path
    end
    #current_user.login_count
  end

end
