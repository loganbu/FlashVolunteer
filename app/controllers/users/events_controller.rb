class Users::EventsController < ApplicationController
  load_and_authorize_resource :user

  def show
    @user = User.find(params[:id])

    @past = Event.includes(:skills).attended_by(@user).past.paginate(:page => params[:page], :per_page => 5)
    @upcoming =  Event.includes(:skills).attended_by(@user).upcoming.paginate(:page => params[:page], :per_page => 5)
    @recommended = Event.includes(:skills).not_attended_by(@user).upcoming.paginate(:page => params[:page], :per_page=>5)
  end

  def update
  end
end
