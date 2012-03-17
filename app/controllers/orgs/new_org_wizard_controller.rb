class Orgs::NewOrgWizardController < Wicked::WizardController
    skip_authorization_check
    steps :set_user_account, :sign_in, :sign_up, :set_contact_info, :set_mission, :set_website

    def show
        @user = current_user
        if (current_user)
            @org = Org.has_admin(current_user).first()
        end
        
        case step
        when :set_user_account
            skip_step if current_user
        when :sign_in
            skip_step if current_user
        when :sign_up
            skip_step if current_user
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
        if (current_user)
            @org = Org.has_admin(current_user).first()
        end

        case step
        when :set_user_account
            
        when :set_contact_info
            @org.update_attributes(params[:org])
        when :set_mission
            @org.update_attributes(params[:org])
        when :set_website
            @org.update_attributes(params[:org])
            @user.show_org_wizard = false
        end
        render_wizard @org
    end
end
