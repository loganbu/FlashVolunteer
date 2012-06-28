class Orgs::EventsController < ApplicationController
  load_and_authorize_resource :org

  # GET /orgs/1/events
  # GET /orgs/1/events.xml
  def show
    @org = Org.find(params[:id])
    authorize_org_profile(@org)

    @past = Event.created_by(@org).past.order("start asc").paginate(:page => params[:page], :per_page => params[:per_page] || 5)
    @upcoming =  Event.created_by(@org).upcoming.order("start asc").paginate(:page => params[:page], :per_page => params[:per_page] || 5)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @org }
    end
  end
end
