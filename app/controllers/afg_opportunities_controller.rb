class AfgOpportunitiesController < ApplicationController
  load_and_authorize_resource

  def index
    @opportunities = AfgOpportunity.not_imported.order("startDate ASC").paginate(:page => params[:page], :per_page => params[:per_page]||20)

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def create_event
    @opportunity = AfgOpportunity.find(params[:id])

    @opportunity.imported = true
    @opportunity.save

    if(@opportunity.neighborhood == nil)
      flash[:warning] = "I don't know the neighborhood '#{@opportunity.neighborhood_string}'"
    end

    @event = Event.new(:name => @opportunity.title,
                       :description => @opportunity.description,
                       :start => @opportunity.start,
                       :end => @opportunity.end,
                       :hosted_by => @opportunity.sponsoringOrganizationName,
                       :website => @opportunity.xml_url,
                       :special_instructions => @opportunity.skills,
                       :street => @opportunity.street,
                       :neighborhood => @opportunity.neighborhood,
                       :zip => @opportunity.zip
                       )

    respond_to do |format|
      format.html { render 'events/edit', :action => "edit" }
    end
  end

  def hide_event
    @opportunity = AfgOpportunity.find(params[:id])
    @opportunity.imported = true
    @opportunity.save

    respond_to do |format|
      format.html { redirect_to(:back) }
    end
  end

  # POST /opportunities/more
  def more
    if(Rails.env.production?)
      AfgOpportunity.delay.download_new_data(params[:afg_count], params[:afg_page])
    else
      AfgOpportunity.download_new_data(params[:afg_count], params[:afg_page])
    end

    respond_to do |format|
      format.html { redirect_to(:back, :notice => "More items requested, they should show up within the next minute or two. If not, try changing the page of results.") }
    end
  end
end
