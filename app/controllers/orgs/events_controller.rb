class Orgs::EventsController < ApplicationController
  load_and_authorize_resource :org

  # GET /orgs/1/events
  # GET /orgs/1/events.xml
  def show
    @org = Org.find(params[:id])

    @past = Event.created_by(@org).past.paginate(:page => params[:page], :per_page => 6)
    @upcoming =  Event.created_by(@org).upcoming.paginate(:page => params[:page], :per_page => 6)


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @org }
    end
  end
end
