class Users::NewUserWizardController < Wicked::WizardController
    skip_authorization_check
    steps :choose_neighborhood, :choose_skills

    def show
        @user = current_user
        case step
        when :choose_neighborhood
            skip_step if @user.neighborhood_id
        when :choose_skills
            skip_step if @user.skills.length > 0
        end
        render_wizard
    end

    def update
        @user = current_user
        case step
        when :choose_neighborhood
            @user.neighborhood_id = params[:neighborhood]
        when :choose_skills
            @user.update_attributes(params[:user])
        end
        render_wizard @user
    end

    def should_remove_returns_to?
        false
    end

    def finish_wizard_path
        returns_to_url
    end
end
