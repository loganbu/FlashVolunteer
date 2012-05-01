class OrgsController < ApplicationController
  load_and_authorize_resource

  # GET /orgs
  # GET /orgs.xml
  def index
    @orgs = Org.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orgs }
    end
  end

  # GET /orgs/1
  # GET /orgs/1.xml
  def show
    @org = Org.find(params[:id])

    @past = Event.created_by(@org).past.paginate(:page => params[:page], :per_page => params[:per_page] || 5)
    @upcoming =  Event.created_by(@org).upcoming.paginate(:page => params[:page], :per_page => params[:per_page] || 5)


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @org }
    end
  end

  # GET /orgs/new
  # GET /orgs/new.xml
  def new
    @org = Org.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @org }
    end
  end

  # GET /orgs/1/edit
  def edit
    @org = Org.find(params[:id])
  end

  # POST /orgs
  # POST /orgs.xml
  def create
    @org = Org.new(params[:org])

    respond_to do |format|
      if @org.save
        format.html { redirect_to(@org, :notice => 'Org was successfully created.') }
        format.xml  { render :xml => @org, :status => :created, :location => @org }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @org.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orgs/1
  # PUT /orgs/1.xml
  def update
    @org = Org.find(params[:id])

    respond_to do |format|
      if @org.update_attributes(params[:org])
        format.html { redirect_to(@org, :notice => 'Org was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @org.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orgs/1
  # DELETE /orgs/1.xml
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
    @orgs = Org.where("1=1")
    
    @orgs = email_array.length > 0 ? @orgs.where{email.eq_any email_array} : @orgs
    @orgs = categories_array.length > 0 ? @orgs.joins(:skills).where{skills.id.eq_any categories_array} : @orgs
    @orgs = name_array.length > 0 ? @orgs.where{name.matches_any name_array} : @orgs
    @orgs = @orgs.paginate(:page=>params[:page], :per_page => per_page)
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @orgs }
    end
  end

end
