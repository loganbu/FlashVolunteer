class EventsController < ApplicationController
  before_filter :see_splash, :only => [:index]
  before_filter :require_organizer, :only => [:update, destroy]
  before_filter :require_authenticated, :only => [:create]
	
	def see_splash
		if !cookies['splash']
			cookies['splash'] = true
			redirect_to neighborhoods_url
		end
	end

	def export
		@event = Event.find(params[:id])
		@calendar = Icalendar::Calendar.new
		event = Icalendar::Event.new
		event.start = @event.start.strftime("%Y%m%dT%H%M%S")
		event.end = @event.end.strftime("%Y%m%dT%H%M%S")
		event.summary = @event.name
		event.description = @event.description
		#event.location = @event.n
		@calendar.add event
		@calendar.publish
		headers['Content-Type'] = "text/calendar; charset=UTF-8"
		render :text => @calendar.to_ical
	end
 
  # GET /events
  # GET /events.xml
  def index
    @events = Event.all
    
    @mapCenter = Neighborhood.all.find { |neighborhood| neighborhood.name.casecmp("downtown")==0 }
    @zoom = 11
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end
  
  # GET /events/in/downtown
  # GET /events/in/downtown.xml
  def in
    @neighborhood = Neighborhood.all.find { |neighborhood| neighborhood.name.casecmp(params[:neighborhood])==0 }
		
		if !@neighborhood
			redirect_to events_url
			return
		else
			@zoom = 15
			@events = @neighborhood.events
			@mapCenter = @neighborhood
		end
		
    respond_to do |format|
      format.html # in.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])
    
    respond_to do |format|
			if params[:map]
				format.html { render 'show.map.erb', :layout=>false }
			else
				format.html # show.html.erb
			end
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
end
