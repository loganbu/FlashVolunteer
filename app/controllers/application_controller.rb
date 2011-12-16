class ApplicationController < ActionController::Base
  theme Flashvolunteer::Application.config.theme
  protect_from_forgery
  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "app/views/shared/authfail.html.erb"
  end
end
