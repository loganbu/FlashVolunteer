class Users::OrganizationsController < ApplicationController
  load_and_authorize_resource :user
  
  def index
    @user_orgs = User.find(params[:user_id]).admin_of.all
  end

  def update

  end
end
