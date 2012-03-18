module SessionsHelper

  def store_url(url)
    session[:return_to] = url
  end
  def send_to_quick_signup(url)
    store_location(url)
    redirect_to quick_new_user_url
  end

  def return_to_here()
    store_location nil
  end

  def send_to_signin(url)
    store_location(url)
    redirect_to new_user_session_url
  end

  def send_to_full_signup(url)
    store_location(url)
    redirect_to new_user_registration_url
  end

  def anyone_signed_in?
    !current_user.nil?
  end

  def get_store_location
    session[:return_to]
  end

  def clear_store_location
    session[:return_to] = nil
  end

  private
    def store_location(url)
      session[:return_to] = url || request.fullpath
    end

end