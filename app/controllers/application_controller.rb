class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery
  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "app/views/shared/authfail.html.erb"
  end


  def after_sign_in_path_for(resource_or_scope)
    store_location = get_store_location
    clear_store_location
    (store_location.nil?) ? root_url : store_location.to_s
  end

private
    before_filter :create_action_and_controller

  def create_action_and_controller
    @current_action = action_name
    @current_controller = controller_name
  end
end
