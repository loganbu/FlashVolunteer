module Devise
    module Models
        module Validatable
            def password_required?
              if (password.nil? && password_confirmation.nil?)
                return false
              else
                return true
              end
            end
        end
    end
end