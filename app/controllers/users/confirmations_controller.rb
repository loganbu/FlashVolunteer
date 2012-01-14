class Users::ConfirmationsController < Devise::ConfirmationsController
  skip_authorization_check
  def show
    @user = User.find_by_confirmation_token(params[:confirmation_token])
    # If the user entered a password through the 'create an account', then the encrypted password is set, and their e-mail is confirmed
    if (@user.encrypted_password != '')
      @user = User.confirm_by_token(@user.confirmation_token)
      @user.roles << Role.find_by_name("Volunteer")
      set_flash_message :notice, :confirmed
      sign_in_and_redirect(@user)
    end
    if !@user.present?
      render_with_scope :new
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