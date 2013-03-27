class ApplicationController < ActionController::Base
    include SessionsHelper
    respond_to :html, :xml

    before_filter :remove_returns_to, :set_default_page_title, :csrf_protect
    protect_from_forgery

    check_authorization :unless => :rails_admin_controller?

    def verified_request?
        session[:api] || super
    end

    rescue_from CanCan::AccessDenied do |exception|
        Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
        render :file => "app/views/shared/authfail.html.erb"
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
        Rails.logger.debug "Record not found #{exception}"
        render :file => "app/views/shared/authfail.html.erb"
    end

    def csrf_protect
        self.allow_forgery_protection = false if session[:api]
    end

    def rails_admin_controller?
      false
    end

    def authorize_user_profile(entity)
        if (!entity || entity.type == "Org")
            raise CanCan::AccessDenied
        end
        authorize! :profile, entity
    end

    def authorize_org_profile(entity)
        if (!entity || entity.type != "Org")
            raise CanCan::AccessDenied
        end
        authorize! :profile, entity
    end

    def set_default_page_title
        @title = "Flash Volunteer"
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

    def current_sponsor
      Sponsor.running.all.sample
    end

    private
        before_filter :create_action_and_controller

        def create_action_and_controller
            @current_action = action_name
            @current_controller = controller_name
        end
end