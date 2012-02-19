class Users::OrganizationsController < ApplicationController
  skip_authorization_check


  def index
    @user_orgs = User.find(params[:user_id]).admin_of.all
  end
end
