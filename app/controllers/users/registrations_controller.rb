class Users::RegistrationsController < Devise::RegistrationsController
  skip_authorization_check
  
  def quick
  end
end
