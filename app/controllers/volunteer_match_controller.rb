class VolunteerMatchController < ApplicationController
  load_and_authorize_resource

  def index
    @opportunities = VolunteerMatchEvent.not_imported.order("start_time ASC").paginate(:page => params[:page], :per_page => params[:per_page]||20)

    respond_to do |format|
      format.html
    end
  end

  def organizations
    @response = VolunteerMatch.search_organizations({:fieldsToDisplay => [:name, :url, :imageUrl], :location => "Seattle, WA"})
    @orgs = @response.organizations
    respond_to do |format|
      format.html
    end
  end

  def opportunities
    @opportunities = VolunteerMatchEvent.not_imported.order("start_time ASC").paginate(:page => params[:page], :per_page => params[:per_page]||20)

    respond_to do |format|
      format.html
    end
  end

  def more

    if Rails.env.production?
      VolunteerMatchEvent.delay.update(params[:vm_pages], params[:vm_offset])
    else
      VolunteerMatchEvent.update(params[:vm_pages], params[:vm_offset])
    end

    respond_to do |format|
      format.html { redirect_to(:back, :notice => "More items requested, they should show up within the next minute or two. If not, try changing the page of results.") }
    end
  end

  def sign_up
    opp = params[:opp].to_i
    email = params[:email]

    VolunteerMatch.sign_up_for_opportunity(email, opp)

    @response = VolunteerMatch.search_opportunities({:fieldsToDisplay =>
                                                     [:availability, :title, :volunteersNeeded, :referralFields, :type, :contact],
                                                     :dateRanges => [{:startDate => "2013-01-27", :endDate=> "2013-03-31"}],
                                                     :location => "Seattle, WA"})
    @opportunities = @response.opportunities

    respond_to do |format|
      format.html
    end
    render :action => "opportunities"
  end

  def users
    @response = VolunteerMatch.search_members({:fieldsToDisplay => [:firstName, :lastName, :email, :primaryKey], :location => "Seattle, WA"})
    @users = @response.members
    respond_to do |format|
      format.html
    end
  end

  def update_user
    name = params[:name]
    email = params[:email]
    password = params[:password]
    
    query = { 
              :members => [
              {
                :firstName => params[:name], 
                :email => params[:email], 
                :password => params[:password],
                :acceptsTermsOfUse => true,
                :location => {},
                :authentication => VolunteerMatch.authentication_query(params[:email], params[:password])                
              }
              ]
            }

    Rails.logger.debug(query)
    VolunteerMatch.create_or_update_members(query)

    @response = VolunteerMatch.search_members({:fieldsToDisplay => [:firstName, :lastName, :email, :primaryKey], :location => "Seattle, WA"})
    @users = @response.members

    render :action => "users"
  end

  def events
  end

end
