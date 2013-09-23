class Orgs::StatsController < ApplicationController
  load_and_authorize_resource :org

  def show
    @org = Org.find(params[:id])
    authorize_org_profile(@org)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @org }
    end
  end
end
