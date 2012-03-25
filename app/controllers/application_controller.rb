class ApplicationController < ActionController::Base
    include SessionsHelper
    before_filter :remove_returns_to
    protect_from_forgery
    check_authorization
    respond_to_mobile_requests :skip_xhr_requests => false, :fall_back => :html

    rescue_from CanCan::AccessDenied do |exception|
        render :file => "app/views/shared/authfail.html.erb"
    end


    def after_sign_in_path_for(resource_or_scope)
        # The wicked gem will do an HTTP get for each step in the flow (even if skipped)
        # to optimize, only show a wizard for users that need it to be shown
        if (current_user.should_show_wizard?)
            new_user_wizard_path(:choose_neighborhood)
        else
            returns_to_url
        end
    end

    def returns_to_url
        store_location = get_store_location
        clear_store_location
        (store_location.nil?) ? root_url : store_location.to_s
    end

    def preferred_neighborhood
        cookies['preferred_neighborhood']
    end

    def remove_returns_to
        clear_store_location if should_remove_returns_to?
    end

    def should_remove_returns_to?
        true
    end

    private
        before_filter :create_action_and_controller

        def create_action_and_controller
            @current_action = action_name
            @current_controller = controller_name
        end
end