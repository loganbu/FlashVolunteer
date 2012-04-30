module UsersHelper

    def sign_in_with_third_party(token_information)
        # You need to implement the method below in your model
        @user = User.find_for_oauth(token_information)
        @user.create_associated_org(session[:org_email], session[:org_name]) if session[:show_org_wizard]

        respond_to do |format|
          format.html do
            if @user.persisted?
              sign_in_and_redirect @user
            else
              redirect_to new_user_registration_url
            end
          end
          format.xml  do
            if @user.persisted?
                head :ok
            else
                head :unauthorized
            end
          end
        end
    end
end
