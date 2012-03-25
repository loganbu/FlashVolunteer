class Users::OrganizationsController < ApplicationController
  load_and_authorize_resource :user
  
  def index
    @admin_of = User.find(params[:user_id]).admin_of.all
    @following = Org.has_follower(User.find(params[:user_id])).all

  end

  def update

  end
end
