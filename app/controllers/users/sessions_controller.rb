class Users::SessionsController < Devise::SessionsController
    include ApplicationHelper
    skip_authorization_check


    def should_remove_returns_to?
        false
    end


  # POST /resource/sign_in
  def create
    super
    store_original_user_logged_in(current_user)
    debugger
  end

end
