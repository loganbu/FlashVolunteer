class Users::EventsController < ApplicationController
  load_and_authorize_resource :user

  def show
    @user = User.find(params[:id])

    @past = Event.attended_by(@user).past.paginate(:page => params[:page], :per_page => 6)
    @upcoming =  Event.attended_by(@user).upcoming.paginate(:page => params[:page], :per_page => 6)
    @recommended = Event.not_attended_by(@user).upcoming.paginate(:page => params[:page], :per_page=>6)
  end

  def update
  end
end
