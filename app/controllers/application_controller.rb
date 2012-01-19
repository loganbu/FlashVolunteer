class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "app/views/shared/authfail.html.erb"
  end
end
