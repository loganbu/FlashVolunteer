class OrgsController < ApplicationController
  load_and_authorize_resource

  def index
    @orgs = Org.all

    respond_to do |format|
      format.html
      format.xml  { render :xml => Org.xml(@orgs) }
    end
  end

  def dashboard
    @test = "hello"
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @org }
    end
  end

  def set_page_title
    @title = ("#{@org.name} | Flash Volunteer") if (@org && @org.name)
  end

  def show
    @org = Org.find(params[:id])

    @past = Event.past.created_by(@org).paginate(:page => params[:page], :per_page => params[:per_page] || 5)
    @upcoming =  Event.upcoming.created_by(@org).paginate(:page => params[:page], :per_page => params[:per_page] || 5)

    set_page_title

    respond_to do |format|
      format.html
      format.xml  { render :xml => Org.xml(@org) }
    end
  end

  def new
    @org = Org.new

    set_page_title

    respond_to do |format|
      format.html
      format.xml  { render :xml => Org.xml(@org) }
    end
  end

  def edit
    @org = Org.find(params[:id])

    set_page_title
  end

  def create
    @org = Org.new(params[:org])

    set_page_title
    respond_to do |format|
      if @org.save
        @org.admins << current_user
        @org.save
        format.html { redirect_to(user_orgs_url(current_user), :notice => 'Organization was successfully created.') }
        format.xml  { render :xml => Org.xml(@org), :status => :created, :location => @org }
      else
        format.html { render :action => 'new' }
        format.xml  { render :xml => @org.errors, :status => :unprocessable_entity }
      end
    end
  end

  def register
    @org = Org.new(params[:org])

    set_page_title
    respond_to do |format|
      if @org.save
        sign_in(@org)
        format.html { redirect_to(new_org_wizard_path(:set_mission), :notice => 'Organization was successfully created.') }
        format.xml  { render :xml => Org.xml(@org), :status => :created, :location => @org }
      else
        flash[:error] = (@org.errors.messages.values.collect{|m| "#{m.first} and "}.join())[0..-5]
        format.html { redirect_to(new_user_registration_url, :error => 'Failed to create organization') }
        format.xml  { render :xml => @org.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @org = Org.find(params[:id])
    set_page_title
    respond_to do |format|
      if @org.update_attributes(params[:org])
        format.html { redirect_to(user_url(@org), :notice => 'Organization was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => 'edit' }
        format.xml  { render :xml => @org.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @org = Org.find(params[:id])
    @org.destroy

    respond_to do |format|
      format.html { redirect_to(orgs_url) }
      format.xml  { head :ok }
    end
  end

  def search
    per_page = params[:per_page] || 5

    email_array = params[:email] && params[:email].split(',') || []
    categories_array = params[:categories] && params[:categories].split(',') || []
    # This probably sucks at scale, need to test
    name_array = params[:name] && params[:name].split(',').collect{ |x| "%" + x + "%"} || []

    # begin with an an association that's always true
    @orgs = Org.where('1=1')
    
    @orgs = email_array.length > 0 ? @orgs.has_admin(User.find_by_email(email_array[0])) : @orgs
    @orgs = categories_array.length > 0 ? @orgs.joins(:skills).where{skills.id.eq_any categories_array} : @orgs
    @orgs = name_array.length > 0 ? @orgs.where{name.matches_any name_array} : @orgs
    @orgs = @orgs.paginate(:page=>params[:page], :per_page => per_page)
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => Org.xml(@orgs) }
    end
  end

end
