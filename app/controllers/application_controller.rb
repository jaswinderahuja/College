class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname,:lastname])
  end  

  def user_status
	 if !user_signed_in?
	    redirect_to(:controller=>"landing",:action=>"index")
	 end 
  end

end
