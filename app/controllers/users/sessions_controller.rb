class Users::SessionsController < Devise::SessionsController
    include ApplicationHelper
    include UsersHelper
    skip_authorization_check


    def should_remove_returns_to?
        false
    end

  def third_party
    respond_to do |format|
      format.html
      format.mobile
    end
  end

  def mobile
    case params[:provider]
    when "facebook"
      self.facebook
    when "google"
      self.google
    end
  end

  def facebook
    token = params[:token]
    auth_hash = get_auth_hash(OmniAuth::Strategies::Facebook.new(ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_API_SECRET']),
                              ENV['FACEBOOK_API_KEY'],
                              ENV['FACEBOOK_API_SECRET'],
                              params[:token])
    sign_in_with_third_party(auth_hash)
  end

  def google
    token = params[:token]
    auth_hash = get_auth_hash(OmniAuth::Strategies::GoogleOauth2.new(ENV['GOOGLE_API_KEY'], ENV['GOOGLE_API_SECRET']),
                              ENV['GOOGLE_API_KEY'],
                              ENV['GOOGLE_API_SECRET'],
                              params[:token])
    sign_in_with_third_party(auth_hash)
  end

  # POST /resource/sign_in
  def create
    super
    if (session[:sign_up_for_event])
        event = Event.find(session[:sign_up_for_event])
        if (event != nil)
          event.participants << current_user if !event.participants.include?(current_user)
        end
        session[:sign_up_for_event] = nil
    end
    store_original_user_logged_in(current_user)
  end

  private

  def get_auth_hash(strategy, key, secret, token)
    client = OAuth2::Client.new(key, secret, strategy.options.client_options)
    oauth_token = OAuth2::AccessToken.new(client, token, strategy.options.access_token_options)
    strategy.access_token = oauth_token
    strategy.auth_hash
  end

end
