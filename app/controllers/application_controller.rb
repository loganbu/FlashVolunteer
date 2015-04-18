class ApplicationController < ActionController::Base
  include SessionsHelper
  include ApplicationHelper
  respond_to :html, :xml

  before_filter :remove_returns_to, :set_default_page_title, :csrf_protect
  protect_from_forgery

  check_authorization :unless => :rails_admin_controller?

  def verified_request?
    session[:api] || super
  end

  def current_ability
    (current_user || User.new).ability
  end

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.info "Access denied on #{exception.action} #{exception.subject.inspect}"
    render :file => 'app/views/shared/authfail.html.erb'
  end

  rescue_from LocationNotFound do |exception|
    Rails.logger.info "Could not find location #{exception.location}"
    render :file => 'app/views/shared/location_not_found.html.erb'
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    Rails.logger.info "Record not found #{exception}"
    render :file => 'app/views/shared/authfail.html.erb'
  end

  def csrf_protect
    self.allow_forgery_protection = false if session[:api]
  end

  def rails_admin_controller?
    false
  end

  def authorize_user_profile(entity)
    if !entity || entity.type == "Org"
      raise CanCan::AccessDenied
    end
    authorize! :profile, entity
  end

  def authorize_org_profile(entity)
    if !entity || entity.type != "Org"
      raise CanCan::AccessDenied
    end
    authorize! :profile, entity
  end

  def set_default_page_title
    @title = 'Flash Volunteer'
  end

  def after_sign_in_path_for(resource_or_scope)
    returns_to_url
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

  def default_url_options
    { :location => nil }
  end

  def set_current_location_name
    cookies['location'] = params[:location] unless params[:location] == nil
  end

  def current_location
    hub = Hub.find_or_initialize_by_name(current_location_name)
    raise LocationNotFound.new(params[:location]) if params[:location] != nil && hub.new_record?
    hub.radius ||= 50
    hub.zoom ||= 15
    hub.center ||= current_location_point
    hub
  end

  private
    before_filter :create_action_and_controller, :set_current_location_name

    def create_action_and_controller
      @current_action = action_name
      @current_controller = controller_name
      @current_location = current_location
    end
end
