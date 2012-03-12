class Orgs::NewOrgWizardController < Wicked::WizardController
    skip_authorization_check
    steps :set_contact_info, :set_mission, :set_website

    def show
        @org = Org.find(current_user.orgs_id)
        case step
        when :set_contact_info
            
        when :set_mission
            skip_step if @org.mission
        when :set_website
            skip_step if @org.website
        end
        render_wizard
    end

    def update
        @org = Org.find(current_user.orgs_id)
        case step
        when :set_contact_info

        when :set_mission

        when :set_website
        end
        render_wizard @org
    end
end
