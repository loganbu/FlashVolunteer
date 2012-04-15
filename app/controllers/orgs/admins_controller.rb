class Orgs::AdminsController < ApplicationController
  load_and_authorize_resource :org

  # GET /orgs/1/stats
  # GET /orgs/1/stats.xml
  def show
    @org = Org.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @org }
    end
  end
end
