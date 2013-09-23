class Users::EventsController < ApplicationController
  load_and_authorize_resource :user

  def show
    @user = User.find(params[:id])
    authorize_user_profile(@user)

    @past = Event.past.involving_user(@user).paginate(:page => params[:page], :per_page => params[:per_page] || 5)
    @upcoming =  Event.upcoming.involving_user(@user).paginate(:page => params[:page], :per_page => params[:per_page] || 5)
    @recommended = Event.recommended_to(@user).paginate(:page => params[:page], :per_page=>params[:per_page] || 5)
  end
end
