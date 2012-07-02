class Orgs::UsersController < ApplicationController
  load_and_authorize_resource :org

  def index
    @org = Org.find(params[:org_id])
    authorize_org_profile(@org)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @org }
    end
  end

  def update
    @org = Org.find(params[:org_id])
    @admin = User.find(params[:id])

    if (!@org.admins.include?(@admin))
      @org.admins << @admin
    end
    respond_to do |format|
      format.html { redirect_to(:back, :notice => "#{@admin.name} is now an admin of #{@org.name}.") }
      format.xml  { render :xml => @org }
    end
  end

  def destroy
    @org = Org.find(params[:org_id])
    @admin = User.find(params[:id])

    if (@org.admins.count > 1)
      @org.admins.delete(@admin)
      flash[:notice] = "#{@admin.name} is no longer an admin of #{@org.name}."
    else
      flash[:alert] = "You cannot remove your last admin"
    end
    
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { render :xml => @org }
    end
  end
end
