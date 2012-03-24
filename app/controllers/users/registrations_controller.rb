class Users::RegistrationsController < Devise::RegistrationsController
    skip_authorization_check

    def quick
    end

    def should_remove_returns_to?
        false
    end
end
