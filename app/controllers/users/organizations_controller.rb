class Users::OrganizationsController < ApplicationController
  load_and_authorize_resource :user
  
  def index
    @user = User.find(params[:user_id])
    authorize_user_profile(@user)
    @admin_of = User.find(@user).admin_of.all
  end
end
