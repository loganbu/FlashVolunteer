class Users::SessionsController < Devise::SessionsController
  include ApplicationHelper
  include UsersHelper
  skip_authorization_check


  def should_remove_returns_to?
    false
  end

  def new
    @title = 'Sign in to your account | Flash Volunteer'
    super
  end

  def third_party
    respond_to do |format|
      format.html
    end
  end

  def mobile
    session[:api] = true
    case params[:provider]
    when 'facebook'
      self.facebook
    when 'google'
      self.google
    when 'twitter'
      self.twitter
    end
  end

  def facebook
    auth_hash = get_auth_hash(OmniAuth::Strategies::Facebook.new(ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_API_SECRET']), params[:token])
    sign_in_with_third_party(auth_hash.extra.raw_info)
  end

  def google
    uri = URI.parse("https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=#{params[:token]}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = Hashie::Mash.new(JSON.parse http.request(request).body)
    sign_in_with_third_party(response)
  end

  def twitter
    auth_hash = get_auth_hash(OmniAuth::Strategies::Twitter.new(ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']), params[:token])
    sign_in_with_third_party(auth_hash.extra.raw_info)
  end

  def create
    super
    if params[:api]
      session[:api] = true
    end
    if session[:sign_up_for_event]
      event = Event.find(session[:sign_up_for_event])
      if event != nil
        event.participants << current_user if !event.participants.include?(current_user)
      end
      session[:sign_up_for_event] = nil
    end
    store_original_user_logged_in(current_user)
  end

  private

  def get_auth_hash(strategy, token)
    strategy.access_token = OAuth2::AccessToken.new(strategy.client, token, strategy.options.access_token_options || {})
    strategy.auth_hash
  end
end
