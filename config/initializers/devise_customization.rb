module Devise
    module Models
        module Validatable
        
            def password_required?
                false
            end
        end
    end
end