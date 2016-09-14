class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      # sanitizes the sign_up form then appends :username the one we added via rails migration
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name])

      # sanitizes the account_update form then appends :username the one we added via rails migration
      devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:last_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:occupation])
      devise_parameter_sanitizer.permit(:account_update, keys: [:company])
      devise_parameter_sanitizer.permit(:account_update, keys: [:location])
      devise_parameter_sanitizer.permit(:account_update, keys: [:website])
    end


end
