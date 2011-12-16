class ApplicationController < ActionController::Base
  theme Flashvolunteer::Application.config.theme
  protect_from_forgery
end
