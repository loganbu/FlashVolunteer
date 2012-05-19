class Users::EventsController < ApplicationController
    load_and_authorize_resource :user

    def show
        @user = User.find(params[:id])
        authorize_user_profile(@user)

        @past = Event.attended_by(@user).past.paginate(:page => params[:page], :per_page => params[:per_page] || 5)
        @upcoming =  Event.attended_by(@user).upcoming.paginate(:page => params[:page], :per_page => params[:per_page] || 5)
        @recommended = Event.not_attended_by(@user).upcoming.paginate(:page => params[:page], :per_page=>params[:per_page] || 5)
    end
end
