class Orgs::NewOrgWizardController < Wicked::WizardController
    include SessionsHelper
    skip_authorization_check
    steps :set_user_account, :set_contact_info, :set_mission, :set_website

    def find_org()
        org = Org.find_by_name(session[:org_name])
        if(@org = nil)
            org = Org.find_by_email(session[:org_email])
        end
        org
    end
    def show
        return_to_here
        @user = current_user
        # if current_user for when the user hasn't signed in yet and we need to get their account
        if (current_user)
            @org = find_org
            if (@org && !@org.admins.include?(current_user))
                @org.errors.add(:email, "This organization has already been created")
            end
        end
        
        case step
        when :set_user_account
            skip_step if current_user
            session[:show_org_wizard] = true
            session[:org_name] = params[:org_name]
            session[:org_email] = params[:org_email]
        when :set_contact_info
            if (@org == nil)
                @org = Org.new(:email => session[:org_email], :name => session[:org_name])
                @org.save
            end
        when :set_mission
            session[:show_org_wizard] = false
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
            @org = find_org
            if (@org && !@org.admins.include?(current_user))
                @org.errors.add(:email, "This organization has already been created")
            end
        end

        case step
        when :set_user_account
            
        when :set_contact_info
            if (@org == nil)
                @org = Org.new(params[:org])
                if (@org.save)
                    session[:org_name] = @org.name
                    session[:org_email] = @org.email
                    @org.admins << current_user
                end
            else
                if (@org.update_attributes(params[:org]))
                    session[:org_name] = @org.name
                    session[:org_email] = @org.email
                    @org.admins << current_user
                end
            end
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
