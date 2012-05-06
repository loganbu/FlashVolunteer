class Users::RegistrationsController < Devise::RegistrationsController
    include ApplicationHelper
    skip_authorization_check

    def quick
    end

    def create
        super
        store_original_user_logged_in(resource)
    end

    def should_remove_returns_to?
        false
    end
end
