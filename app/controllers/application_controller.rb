class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "app/views/shared/authfail.html.erb"
  end

private
    before_filter :create_action_and_controller

  def create_action_and_controller
    @current_action = action_name
    @current_controller = controller_name
  end
end
