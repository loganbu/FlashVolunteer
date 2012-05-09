module UsersHelper
    def devise_error_messages!    
      return "" if resource.errors.empty?

      messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
      sentence = I18n.t("errors.messages.not_saved",
                        :count => resource.errors.count,
                        :resource => resource.class.model_name.human.downcase)

      html = <<-HTML
      <div class="alert alert-error">
        <a class="close" data-dismiss="alert" href="#">x</a>
        <h4 class="alert-heading">#{sentence}</h4>
        <p>
            <ul>
              #{messages}
            </ul>
        </p>
      </div>
      HTML

      html.html_safe
    end

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
