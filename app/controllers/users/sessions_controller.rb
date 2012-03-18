class Users::SessionsController < Devise::SessionsController
    skip_authorization_check


    def should_remove_returns_to?
        false
    end
end
