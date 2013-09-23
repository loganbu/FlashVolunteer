class Orgs::EventsController < ApplicationController
  load_and_authorize_resource :org

  def show
    @org = Org.find(params[:id])
    authorize_org_profile(@org)

    @past = Event.past.created_by_user(@org).paginate(:page => params[:page], :per_page => params[:per_page] || 5)
    @upcoming =  Event.past.created_by_user(@org).paginate(:page => params[:page], :per_page => params[:per_page] || 5)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @org }
    end
  end
end
