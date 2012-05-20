class Users::RegistrationsController < Devise::RegistrationsController
    include ApplicationHelper
    skip_authorization_check

    def quick
    end

    def create
        super
        if (session[:sign_up_for_event])
            event = Event.find(session[:sign_up_for_event])
            if (event != nil)
                event.participants << current_user if !event.participants.include?(current_user)
            end
            session[:sign_up_for_event] = nil
        end
        store_original_user_logged_in(resource)
    end

    def should_remove_returns_to?
        false
    end
end
