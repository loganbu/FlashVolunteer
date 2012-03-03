class Users::EventsController < ApplicationController
  load_and_authorize_resource :user

  def show
    @past = Event.attended_by(current_user).past.paginate(:page => params[:page], :per_page => 6)
    @upcoming =  Event.attended_by(current_user).upcoming.paginate(:page => params[:page], :per_page => 6)
    @recommended = Event.upcoming.paginate(:page => params[:page], :per_page=>6)
  end

  def update
  end
end
