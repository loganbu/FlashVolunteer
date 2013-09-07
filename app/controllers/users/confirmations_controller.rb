class Users::ConfirmationsController < Devise::ConfirmationsController
  skip_authorization_check

  def create
    super
    flash[:alert] = "You should receive an e-mail from Charlie soon"
  end

  def show
    @user = User.find_by_confirmation_token(params[:confirmation_token])
    # If the user entered a password through the 'create an account', then the encrypted password is set, and their e-mail is confirmed
    if (@user != nil)
      @user = User.confirm_by_token(@user.confirmation_token)
      @user.roles << Role.find_by_name("Volunteer")
      set_flash_message :notice, :confirmed
      sign_in_and_redirect(@user)
    else
      flash[:warning] = "This account is already confirmed. Please sign in to access your account. Lost the e-mail? You can #{self.class.helpers.link_to 'resend the instructions', new_user_confirmation_url}.".html_safe
      redirect_to(events_url(current_location_name))
    end
  end

  def confirm_account
    @user = User.find_by_confirmation_token(params[:user][:confirmation_token])
    if @user.update_attributes(params[:user]) and @user.password_match?
      @user = User.confirm_by_token(@user.confirmation_token)
      @user.roles << Role.find_by_name("Volunteer")
      set_flash_message :notice, :confirmed      
      sign_in_and_redirect(@user)
    else
      render :action => "show"
    end
  end
end
