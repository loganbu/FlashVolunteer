class Orgs::NewOrgWizardController < Wicked::WizardController
    include SessionsHelper
    skip_authorization_check
    steps :set_user_account, :set_contact_info, :set_mission, :set_website

    def show
        return_to_here
        @user = current_user
        # if current_user for when the user hasn't signed in yet and we need to get their account
        if (current_user)
            @org = Org.has_admin(@user).first()
        end
        
        case step
        when :set_user_account
            skip_step if current_user
            session[:show_org_wizard] = true
            session[:org_name] = params[:org_name]
            session[:org_email] = params[:org_email]
        when :set_contact_info
            
        when :set_mission
            skip_step if @org.mission
        when :set_website
            skip_step if @org.website
        end
        render_wizard
    end

    def update
        @user = current_user
        # if current_user for when the user hasn't signed in yet and we need to get their account
        if (current_user)
            @org = Org.has_admin(@user).first()
        end

        case step
        when :set_user_account
            
        when :set_contact_info
            @org.update_attributes(params[:org])
        when :set_mission
            @org.update_attributes(params[:org])
        when :set_website
            @org.update_attributes(params[:org])
        end
        render_wizard @org
    end

    def should_remove_returns_to?
        false
    end
end
