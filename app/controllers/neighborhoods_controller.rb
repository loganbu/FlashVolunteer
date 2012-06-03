class NeighborhoodsController < ApplicationController
  include SessionsHelper
  load_and_authorize_resource
  
  # GET /neighborhoods
  # GET /neighborhoods.xml
  def index
    @neighborhoods = Neighborhood.find(:all, :order => "name")
    @preferred_neighborhood = Neighborhood.where(:id => preferred_neighborhood).first
    
    @preferred_neighborhood_id = @preferred_neighborhood ? @preferred_neighborhood.id : nil

    @title="Find Volunteering Opportunities"
    
    respond_to do |format|
      format.html # index.html.erb
      format.mobile
      format.xml  { render :xml => @neighborhoods }
    end
  end

  def search
    per_page = params[:per_page] || 5
    proximity = params[:proximity] || 5

    lat_long = (params[:lat] && params[:long]) ? [params[:lat].to_f, params[:long].to_f] : [47.618777, -122.33139]

    # begin with an an association that's always true
    @neighborhoods = Neighborhood.where("1=1").near(lat_long, proximity).paginate(:page=>params[:page], :per_page => per_page)
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @neighborhoods }
    end
  end


end
