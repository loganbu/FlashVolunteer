class Users::RegistrationsController < Devise::RegistrationsController
    include ApplicationHelper
    skip_authorization_check

    def quick
    end

    def new
        @title = "Create an account | Flash Volunteer"
        @org = Org.new
        super
    end

    def create
        @org = Org.new
        super
        if (session[:sign_up_for_event] && current_user != nil)
            event = Event.find(session[:sign_up_for_event])
            if (event != nil)
                event.participants << current_user if !event.participants.include?(current_user)
            end
            session[:sign_up_for_event] = nil
        end
        store_original_user_logged_in(resource)

        respond_to do |format|
            format.xml  { render :xml => User.xml(@user) }
            return
        end
    end

    def should_remove_returns_to?
        false
    end
end
