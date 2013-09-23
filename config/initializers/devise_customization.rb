module Devise
  module Models
    module Validatable
      def password_required?
        if password.nil? && password_confirmation.nil?
          false
        else
          true
        end
      end
    end

    module Confirmable
      if Rails.env.production?
        handle_asynchronously :send_confirmation_instructions
      end
    end

    module Recoverable
      if Rails.env.production?
        handle_asynchronously :send_reset_password_instructions
      end
    end

    module Lockable
      if Rails.env.production?
        handle_asynchronously :send_unlock_instructions
      end
    end
  end
end