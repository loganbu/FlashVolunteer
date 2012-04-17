class Events::CheckinController < ApplicationController
  include SessionsHelper
  skip_authorization_check

  # POST /events/1/checkin
  def create
    @event = Event.find(params[:id])
      
    
    respond_to do |format|
      format.html { redirect_to(confirm_event_url, @event) } 
      format.xml  { render :xml => @event, :status => :created, :location => @event }
    end
  end

  # GET /events/1/checkin
  def show
    @event = Event.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { head :ok }
    end
  end

  def confirm
    @event = Event.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml  { head :ok }
    end
  end
end
