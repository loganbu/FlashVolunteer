class Users::PrivacyController < ApplicationController
  load_and_authorize_resource :user

  def show
    @user = User.find(params[:id])
    @privacy = Privacy.find_or_create_by_user_id(@user.id)
  end

  def update
    @user = User.find(params[:id])
    @privacy = Privacy.find_or_create_by_user_id(@user.id)
    @privacy.upcoming_events = params[:privacy][:upcoming_events]
    @privacy.save!
    redirect_to(:back)
  end
end
