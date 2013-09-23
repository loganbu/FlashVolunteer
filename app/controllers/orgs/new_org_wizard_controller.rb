class Orgs::NewOrgWizardController < Wicked::WizardController
  include SessionsHelper
  skip_authorization_check
  steps :set_mission, :set_website

  def find_org
    org = nil
    org = current_user unless current_user.type != 'Org'
    if org == nil
      org = Org.find_by_name(session[:org_name])
    end
    if org == nil
      org = Org.find_by_email(session[:org_email])
    end
    org
  end

  def show
    return_to_here
    @user = current_user
    @org = find_org
    case step
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
    @org = find_org
    case step
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
