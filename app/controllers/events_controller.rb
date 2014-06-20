class EventsController < ApplicationController
  load_and_authorize_resource

  def export
    @event = Event.find(params[:id])
    @calendar = Icalendar::Calendar.new
    event = Icalendar::Event.new
    event.start = @event.start.strftime('%Y%m%dT%H%M%S')
    event.end = @event.end.strftime('%Y%m%dT%H%M%S')
    event.summary = @event.name
    event.description = @event.description
    #event.location = @event.n
    @calendar.add event
    @calendar.publish
    headers['Content-Type'] = 'text/calendar; charset=UTF-8'
    render :text => @calendar.to_ical
  end
 
  def set_page_title
    @title = @event.name if @event
  end

  def index
    per_page = params[:per_page] || 4

    Rails.logger.info("Location: #{@current_location.center.to_s}")
    @events = Event.includes(participants: [{participations: :user}]).includes(:skills, :user, :affiliates).upcoming.near_user(@current_location).paginate(:page => params[:page], :per_page=>per_page)
    @map_center = current_location

    @title = "Volunteer Opportunities in #{current_location.name}"
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => Event.xml(@events) }
    end
  end

  def this
    end_date = params[:timeframe]

    case end_date.downcase
    when 'hour', 'day', 'week', 'month', 'year'
      end_date = Time.now + 1.send(end_date.downcase)
    else
      redirect_to events_url(current_location_name)
      return
    end

    @map_center = current_location
    @events = Event.near_user(current_location).before(end_date).after(DateTime.now).paginate(:page => params[:page], :per_page=>params[:per_page] || 4)
    @zoom = 11

    respond_to do |format|
      format.html
      format.xml { render :xml => Event.xml(@events) }
    end
  end

  def featured
    @events = Event.includes(:neighborhood).near_user(current_location).featured.upcoming
    @current_sponsor = current_sponsor

    if @events.featured.count == 0
      @events = Event.near_user(current_location).upcoming.paginate(:page => params[:page], :per_page=> 6)
    end

    @title = "Featured Volunteer Opportunities in #{current_location.name}"
    
    respond_to do |format|
      format.html { render 'featured.html.erb', :layout => 'alt_layout.html.erb' }
    end
  end

  def in
    @neighborhood = Neighborhood.where('(name_friendly=? and city_friendly=?) or (name=? and city=?)', params[:neighborhood], params[:city], params[:neighborhood], params[:city])

    if @neighborhood
      cookies['preferred_neighborhood'] = @neighborhood.id
      @title = "Volunteer Opportunities in #{@neighborhood.name}"
      @zoom = 15
      @events = Event.in_neighborhood(@neighborhood).upcoming.order("start asc").paginate(:page => params[:page], :per_page=>params[:per_page] || 5)
      @map_center = @neighborhood
    else
      redirect_to events_url(current_location_name)
      return
    end

    respond_to do |format|
      format.html # in.html.erb
      format.xml  { render :xml => Event.xml(@events) }
    end
  end

  def print
    @event = Event.find(params[:id])
    
    respond_to do |format|
      format.html { render 'print.html.erb', :layout => 'blank' }
      format.pdf do 
        render :pdf => @event.name
      end
    end
  end

  def show
    @event = Event.includes(:affiliates).find(params[:id])
    
    set_page_title

    respond_to do |format|
      if params[:map]
          format.html { render 'show.map.erb', :layout=>false }
      else
          format.html
      end
      format.xml  { render :xml => Event.xml(@event) }
    end
  end

  def new
    @event = Event.new
    @event.affiliates << current_user.affiliates
    
    set_page_title

    respond_to do |format|
      format.html
      format.xml  { render :xml => Event.xml(@event) }
    end
  end

  def clone
    old_event = Event.find(params[:id])

    @event = Event.new(old_event.attributes)
    @event.skills = old_event.skills

    set_page_title

    respond_to do |format|
      format.html { render 'events/edit', :action => 'edit' }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.includes(:skills, :affiliates).find(params[:id])

    set_page_title
  end

  def hackoutdatetime(start_date, hashSet)
    return hashSet if start_date == nil
    # Because there is no good DateTime picker, we are using a stupid field in the :params
    # for the start date... this needs to be removed for the update_attributes call below.
    # Then, we need to update the year/month/date fields ourselves, as a string format.
    start_date = Date.strptime(start_date, '%m/%d/%Y')
    hashSet['start(1i)']= start_date.year < 100 ? (start_date.year+2000).to_s : start_date.year.to_s
    hashSet['start(2i)']=start_date.month.to_s
    hashSet['start(3i)']=start_date.day.to_s
    hashSet['end(1i)']=start_date.year < 100 ? (start_date.year+2000).to_s : start_date.year.to_s
    hashSet['end(2i)']=start_date.month.to_s
    hashSet['end(3i)']=start_date.day.to_s
    hashSet
  end

  def create
    if params[:event][:website] != nil && params[:event][:website] != '' && !(params[:event][:website].starts_with?("http://") || params[:event][:website].starts_with?("https://"))
      params[:event][:website] = "http://" + params[:event][:website]
    end

    begin
      params_to_use = hackoutdatetime(params[:startdate], params[:event])
      @event = Event.new(params_to_use)
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
        format.html { render :action => 'new' }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @event = Event.find(params[:id])

    begin
      params_to_use = hackoutdatetime(params[:startdate], params[:event])
    rescue ArgumentError
      params_to_use = params[:event].delete('startdate')
      @event.start = nil
    end

    set_page_title

    if params[:event][:website] != nil &&  params[:event][:website] != '' && !(params[:event][:website].starts_with?('http://') || params[:event][:website].starts_with?('https://'))
      params[:event][:website] = "http://#{params[:event][:website]}"
    end

    respond_to do |format|
      if @event.update_attributes(params_to_use)
        format.html { redirect_to(@event, :notice => 'Event was successfully updated. Consider contacting the volunteers if they need to be notified of the change.') }
        format.xml  { head :ok }
      else
        format.html { render :action => 'edit' }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # POST /events/1
  def broadcast
    @event = Event.includes(:participants).find(params[:id])
    message = params[:message]

    @event.participants.each do |p|
      if p.notification_preferences.where(:name => 'organizer_broadcast').count > 0
        if Rails.env.production?
          # send the e-mail
          UserMailer.delay.organizer_broadcast(@event, p, message)
        else
          UserMailer.organizer_broadcast(@event, p, message).deliver
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to(:back, :notice => 'An e-mail will be sent to the attendees with the specified message') }
      format.xml { head :ok }
    end
  end

  def destroy
    @event = Event.find(params[:id])

    flash[:info] = "#{@event.name} has been removed from our system."

    @event.destroy

    respond_to do |format|
      format.html { redirect_to(user_url(current_user)) }
      format.xml  { head :ok }
    end
  end


  def instructions
    respond_to do |format|
      format.html
      format.xml  { head :ok }
    end
  end


  def search
    per_page = params[:per_page] || 5
    proximity = params[:proximity] || ((params[:lat] || params[:long]) ? 5 : 100)
    
    lat_long = (params[:latitude] && params[:longitude]) ? [params[:latitude].to_f, params[:longitude].to_f] : [47.618777, -122.33139]
    @events = Event.where('1=1').near(lat_long, proximity)
    
    id_array = params[:id] && params[:id].split(',') || []
    categories_array = params[:categories] && params[:categories].split(',') || []

    if params[:org] == 'true'
      if current_user
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
    name_array = params[:name] && params[:name].split(',').collect{ |x| '%' + x + '%'} || []

    if params.key? :upcoming
      num_days_future = params[:upcoming] && params[:upcoming].to_i
      @events = @events.upcoming(num_days_future)
    end
    if params.key? :past
      num_days_past = params[:past] && params[:past].to_i
      @events = @events.past(num_days_past)
    end

    # Show events that are participated by my team
    if current_user
      followers = current_user.followers
      @events = params[:team] ? @events.joins(:participants).where{participations.user_id.eq_any followers} : @events
    end

    # Show events that are created by my orgs
    if current_user
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
    @events = @events.where(vm_id: 0)
    @events = @events.paginate(:page=>params[:page], :per_page => per_page)

    respond_to do |format|
      format.html
      format.xml  { render :xml => Event.xml(@events) }
      format.json { render :json => Event.json(@events) }
    end
  end  
end
