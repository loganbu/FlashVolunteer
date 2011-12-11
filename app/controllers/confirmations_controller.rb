class ConfirmationsController < Devise::ConfirmationsController
  # GET /users/1
  # GET /users/1.xml
  def show
    @account = User.find_by_confirmation_token(params[:confirmation_token])
    if !@account.present?
      render_with_scope :new
    end
  end

  def confirm_account
    @account = User.find(params[:account][:confirmation_token])
    if @account.update_attributes(params[:account]) and @account.password_match?
      @account = User.confirm_by_token(@account.confirmation_token)
      set_flash_message :notice, :confirmed      
      sign_in_and_redirect("event", @account)
    else
      render :action => "show"
    end
  end
end
