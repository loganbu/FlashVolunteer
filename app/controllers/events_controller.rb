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
 
  def set_page_title
    @title = @event.name if @event
  end

  # GET /events
  # GET /events.xml
  def index
    per_page = params[:per_page] || 4
    
    @mapCenter = Neighborhood.all.find { |neighborhood| neighborhood.name.casecmp("downtown seattle")==0 }
    @events = Event.upcoming.order("start asc").paginate(:page => params[:page], :per_page=>params[:per_page] || 4)
    @zoom = 11

    @title="Volunteer Opportunities in King County"
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => Event.xml(@events) }
    end
  end

  def this
    end_date = params[:timeframe];

    case end_date.downcase
    when "hour", "day", "week", "month", "year"
      end_date = Time.now + 1.send(end_date.downcase)
    else
      redirect_to events_url
      return
    end

    Rails.logger.info(end_date)

    @mapCenter = Neighborhood.all.find { |neighborhood| neighborhood.name.casecmp("downtown seattle")==0 }
    @events = Event.before(end_date).order("start asc").paginate(:page => params[:page], :per_page=>params[:per_page] || 4)
    @zoom = 11

    respond_to do |format|
      format.html
      format.xml { render :xml => Event.xml(@events) }
    end
  end

  # GET /events/featured
  def featured
    @events = Event.featured.upcoming
    if (@events.featured.count == 0)
      @events = Event.upcoming.order("start asc").paginate(:page => params[:page], :per_page=> 6)
    end
    @title = "Featured Volunteer Opportunities in King County"
    
    respond_to do |format|
      format.html # featured.html.erb
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
      @title = "Volunteer Opportunities in " + @neighborhood.name
      @zoom = 15
      @events = Event.where(:neighborhood_id => @neighborhood.id).upcoming.order("start asc").paginate(:page => params[:page], :per_page=>params[:per_page] || 5)
      @mapCenter = @neighborhood
    end

    respond_to do |format|
      format.html # in.html.erb
      format.xml  { render :xml => Event.xml(@events) }
    end
  end

  def print
    @event = Event.find(params[:id])
    
    respond_to do |format|
      format.html { render 'print.html.erb', :layout => "blank" }
      format.pdf do 
        render :pdf => "#{@event.name}"
      end
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])
    
    set_page_title

    respond_to do |format|
      if params[:map]
          format.html { render 'show.map.erb', :layout=>false }
      else
          format.html # show.html.erb
      end
      format.xml  { render :xml => Event.xml(@event) }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
    
    set_page_title

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => Event.xml(@event) }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])

    set_page_title
  end

  def hackoutdatetime(startdate, hashSet)
    # Because there is no good DateTime picker, we are using a stupid field in the :params
    # for the start date... this needs to be removed for the update_attributes call below.
    # Then, we need to update the year/month/date fields ourselves, as a string format.
    startdate = Date.strptime(startdate, '%m/%d/%Y')
    hashSet["start(1i)"]= startdate.year < 100 ? (startdate.year+2000).to_s : startdate.year.to_s
    hashSet["start(2i)"]=startdate.month.to_s
    hashSet["start(3i)"]=startdate.day.to_s
    hashSet["end(1i)"]=startdate.year < 100 ? (startdate.year+2000).to_s : startdate.year.to_s
    hashSet["end(2i)"]=startdate.month.to_s
    hashSet["end(3i)"]=startdate.day.to_s
    hashSet
  end

  # POST /POST
  # events /events.xml
  def create

    if (params[:event][:website] != nil && params[:event][:website] != '' && !(params[:event][:website].starts_with?("http://") || params[:event][:website].starts_with?("https://")))
      params[:event][:website] = "http://" + params[:event][:website]
    end

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

    begin
      paramsToUse = hackoutdatetime(params[:startdate], params[:event])
    rescue ArgumentError
      paramsToUse = params[:event].delete('startdate')
      @event.start = nil
    end

    set_page_title

    if (params[:event][:website] != '' && !(params[:event][:website].starts_with?("http://") || params[:event][:website].starts_with?("https://")))
      params[:event][:website] = "http://" + params[:event][:website]
    end

    respond_to do |format|
      if @event.update_attributes(paramsToUse)
        format.html { redirect_to(@event, :notice => "Event was successfully updated. Consider <a href='javascript:revealModal(\"contact_users\")'>contacting the volunteers</a> if they need to be notified of the change.".html_safe) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # POST /events/1
  def broadcast
    @event = Event.includes(:participants).find(params[:id])
    message = params[:message]

    @event.participants.includes(:notification_preferences).each do |p|
      if (p.notification_preferences.where(:name => "organizer_broadcast").count > 0)
        if Rails.env.production?
          # send the e-mail
          UserMailer.delay.organizer_broadcast(@event, p, message)
        else
          UserMailer.organizer_broadcast(@event, p, message).deliver
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to(:back, :notice => "An e-mail will be sent to the attendees with the specified message") }
      format.xml { head :ok }
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])

    flash[:info] = "#{@event.name} has been removed from our system."

    @event.destroy

    respond_to do |format|
      format.html { redirect_to(user_url(current_user)) }
      format.xml  { head :ok }
    end
  end


  # DELETE /events/instructions
  def instructions
    respond_to do |format|
      format.html
      format.xml  { head :ok }
    end
  end


  def search
    per_page = params[:per_page] || 5
    proximity = params[:proximity] || ((params[:lat] || params[:long]) ? 5 : 100)
    
    lat_long = (params[:lat] && params[:long]) ? [params[:lat].to_f, params[:long].to_f] : [47.618777, -122.33139]
    @events = Event.where("1=1").near(lat_long, proximity)
    
    id_array = params[:id] && params[:id].split(',') || []
    categories_array = params[:categories] && params[:categories].split(',') || []

    if (params[:org] == "true")
      if (current_user)
        hosted_by_org_user_array = [current_user.id]
      else
        hosted_by_org_user_array = [0]
      end
    else
      hosted_by_org_user_array = (params[:hosted_by_org_user] && params[:hosted_by_org_user].split(',')) || []
    end

    created_by_array = params[:created_by] && params[:created_by].split(',') || []
    participated_by_array = params[:participated_by] && params[:participated_by].split(',') || []
    recommended_to = params[:recommended_to]

    # This probably sucks at scale, need to test.  Makes "name=blah" into a SQL statement of LIKE %BLAH%
    name_array = params[:name] && params[:name].split(',').collect{ |x| "%" + x + "%"} || []

    if (params.key? :upcoming)
      num_days_future = (params[:upcoming] && params[:upcoming].to_i) || false
      @events = @events.upcoming(num_days_future)
    end
    if (params.key? :past)
      num_days_past = (params[:past] && params[:past].to_i) || false
      @events = @events.past(num_days_past)
    end

    # Show events that are participated by my team
    if (current_user)
      followers = current_user.followers
      @events = params[:team] ? @events.joins(:participants).where{participations.user_id.eq_any followers} : @events
    end

    # Show events that are created by my orgs
    if (current_user)
      admin_of = current_user.admin_of
      @events = params[:org] ? @events.where{creator_id.eq_any admin_of} : @events
    end

    # begin with an an association that's always true
    @events = id_array.length > 0 ? @events.where{id.eq_any id_array} : @events
    @events = categories_array.length > 0 ? @events.joins(:skills).where{skills.id.eq_any categories_array} : @events
    @events = name_array.length > 0 ? @events.where{name.matches_any name_array} : @events
    @events = hosted_by_org_user_array.length > 0 ? @events.hosted_by_org_user(hosted_by_org_user_array) : @events
    @events = created_by_array.length > 0 ? @events.where{creator_id.eq_any created_by_array} : @events
    @events = participated_by_array.length > 0 ? @events.joins(:participants).where{participations.user_id.eq_any participated_by_array} : @events
    @events = recommended_to != nil ? @events.recommended_to(User.find_by_id(recommended_to)) : @events
    @events = @events.paginate(:page=>params[:page], :per_page => per_page)

    respond_to do |format|
      format.html
      format.xml  { render :xml => Event.xml(@events) }
      format.json { render :json => Event.json(@events) }
    end
  end
  
  private
    def see_splash
        if !cookies['splash'] && request.format == Mime::HTML
            cookies['splash'] = true
            redirect_to featured_events_url
        end
    end
end
