class UsersController < ApplicationController
  include ApplicationHelper
  load_and_authorize_resource

  def index    
    if current_user == nil
      redirect_to events_url
    else
      redirect_to events_user_url(current_user)
    end
  end

  # GET /users/1/switch
  def switch
    @user = User.find(params[:id])
    @original_user = User.find(original_user_logged_in)

    if @user == @original_user || (@user.type == "Org" && Org.has_admin(@original_user).include?(@user))
      sign_in_and_redirect @user
    else
      raise CanCan::AccessDenied
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.includes(:neighborhood).find(params[:id])

    # user calculations
    @nEventsCreated = Event.created_by(@user).count
    @nEventsComingUp = Event.attended_by(@user).upcoming.count
    @nEventsInPast = Event.attended_by(@user).past.count
    @nFollowers = @user.followers.count

    # events
    @events = Event.includes(:skills).joins(:participants).where('users.id' => @user.id)
    if !params[:page]
      logger.info "Retrieving the next 10 upcoming events"
      @events = @events.limit(10).order('start ASC').upcoming.where('start < ?', Time.now + 2.months)
    else
      logger.info "Retrieivng past events"
      @events = @events.paginate(:page => params[:page]).past.order('start DESC')
    end
    @eventsJson = @events.to_json(:include => :skills)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def upcoming
    @user = User.find(params[:id])
    @events = Event.joins(:participants).where('users.id' => @user.id)
  end

  def recommended
    @user = User.find(params[:id])
  end

  def stats
    @user = User.find(params[:id])
  end

  def team
    @user = User.find(params[:id])
  end

end
