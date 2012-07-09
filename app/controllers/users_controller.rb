class UsersController < ApplicationController
  include ApplicationHelper
  load_and_authorize_resource

  def index    
    if current_user == nil
      redirect_to events_url
    elsif current_user.type == "Org"
      redirect_to events_org_url(current_user)
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

  def set_page_title
    @title = @user.name + "'s Flash Volunteer Profile" if @user
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.includes(:neighborhood).find(params[:id])
    limit = 20
    set_page_title
    # user calculations
    @nEventsCreated = Event.created_by(@user).count
    @nEventsComingUp = Event.involving(@user).upcoming.count
    @nEventsInPast = Event.involving(@user).past.count
    # @nFollowers = @user.followers.count
    @nHoursVolunteered = Participation.where("user_id = ?", @user.id).sum(:hours_volunteered)

    @events = { 
                :upcoming => { :data => Event.includes(:skills).joins(:participants).involving(@user).upcoming.order("start ASC").limit(limit), :title => "Upcoming" },
                :past => { :data => Event.includes(:skills).joins(:participants).involving(@user).past.order("start DESC").limit(limit), :title => "Past" }
              }
    @events[:past][:json] = @events[:past][:data].to_json
    @events[:upcoming][:json] = @events[:upcoming][:data].to_json

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => User.xml(@user) }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    authorize_user_profile(@user)
    set_page_title
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @user = User.find(params[:id])

    if (!params[:user][:skill_ids])
      @user.skills = []
    end
    set_page_title
    respond_to do |format|
      if @user.update_attributes(params[:user])
        notice = "Your profile was successfully updated."
        if (params[:user] && params[:user][:email] != @user.email)
          notice.concat("  You need to confirm your new e-mail address before you can use it.  Instructions have been e-mailed to #{params[:user][:email]}")
        end
        format.html { redirect_to(@user, :notice => notice) }
        format.mobile { redirect_to(@user, :notice => notice) }
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

  # DELETE /user/:id/photo
  def photo
    @user = User.find(params[:id])
    @user.avatar = nil
    @user.save!
    respond_to do |format|
      format.html { redirect_to(:back, :notice => 'Your photo was removed') }
      format.mobile { redirect_to(:back, :notice => 'Your photo was removed') }
      format.xml { head :ok }
    end
  end

  def search
    per_page = params[:per_page] || 5

    id_array = params[:id] && params[:id].split(',') || []
    email_array = params[:email] && params[:email].split(',') || []
    categories_array = params[:categories] && params[:categories].split(',') || []
    team_array = params[:on_team] && params[:on_team].split(',') || []

    # begin with an an association that's always true
    @users = User.where("1=1")
    
    @users = id_array.length > 0 ? @users.where{id.eq_any id_array} : @users
    @users = email_array.length > 0 ? @users.where{email.eq_any email_array} : @users
    @users = categories_array.length > 0 ? @users.joins(:skills).where{skills.id.eq_any categories_array} : @users
    @users = team_array.length > 0 ? @users.joins(:followers).where{users_followers.follower_id.eq_any team_array} : @users
    @users = @users.paginate(:page=>params[:page], :per_page => per_page)
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => User.xml(@users)}
    end
  end

end
