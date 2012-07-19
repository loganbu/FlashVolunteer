class Users::CheckinController < ApplicationController
    load_and_authorize_resource :user

    # Prop the user
    def create
        @checkin = Checkin.new
        @checkin.user = User.find_by_id(params[:id])
        @checkin.errors.add("You must be signed in to check in") if @checkin.user == nil
        @checkin.event = Event.find_by_id(params[:event_id])
        @checkin.errors.add("Cannot find the specified event") if @checkin.event == nil


        respond_to do |format|
          if @checkin.save
            format.html { redirect_to(@checkin.event, :notice => 'You have been checked in to this event') }
            format.mobile { redirect_to(@checkin.event, :notice => 'You have been checked in to this event') }
            format.xml  { render :xml => @checkin, :status => :created }
          else
            format.html { redirect_to(@checkin.event) }
            format.mobile { redirect_to(@checkin.event) }
            format.xml  { render :xml => @checkin.errors, :status => :unprocessable_entity }
          end
        end
    end
end
