class EventsController < ApplicationController
  before_filter :see_splash, :only => [:index]
  load_and_authorize_resource
    
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
    @events = Event.upcoming.paginate(:page => params[:page], :per_page=>5)
    @events.each_with_index do |event, i|
      event['user_participates'] = event.attending?(current_user)
    end
    
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
      cookies['preferred_neighborhood'] = @neighborhood.id
      @zoom = 15
      @events = Event.where(:neighborhood_id => @neighborhood.id).upcoming.paginate(:page => params[:page], :per_page=>6)
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
    @event['user_participates'] = @event.attending?(current_user)
    
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

  def hackoutdatetime(startdate, hashSet)
    # Because there is no good DateTime picker, we are using a stupid field in the :params
    # for the start date... this needs to be removed for the update_attributes call below.
    # Then, we need to update the year/month/date fields ourselves, as a string format.
    startdate = Date.strptime(startdate, '%m/%d/%Y')
    hashSet["start(1i)"]=startdate.year.to_s
    hashSet["start(2i)"]=startdate.month.to_s
    hashSet["start(3i)"]=startdate.day.to_s
    hashSet["end(1i)"]=startdate.year.to_s
    hashSet["end(2i)"]=startdate.month.to_s
    hashSet["end(3i)"]=startdate.day.to_s
    hashSet
  end

  # POST /POST
  # events /events.xml
  def create
    begin
      paramsToUse = hackoutdatetime(params[:startdate], params[:event])
      @event = Event.new(paramsToUse)
    rescue ArgumentError
      params[:event].delete('startdate')
      @event = Event.new(params[:event])
      @event.start = nil
    end
    
    @event.user = current_user

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
    paramsToUse = hackoutdatetime(params[:startdate], params[:event])

    respond_to do |format|
      if @event.update_attributes(paramsToUse)
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
  
  private
  
    def see_splash
        if !cookies['splash']
            cookies['splash'] = true
            redirect_to neighborhoods_url
        end
    end
end
