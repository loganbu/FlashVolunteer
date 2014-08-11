class Orgs::DashboardController < ApplicationController
  load_and_authorize_resource :org

  def show
    @org = Org.find(params[:id])
    @totalhours = @org.hours_volunteered_for_org;
    @totalvolunteersthismonth = @org.past_volunteers.count;
    authorize_org_profile(@org)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @org }
    end
  end
end
