class NeighborhoodsController < ApplicationController
  load_and_authorize_resource
  
  # GET /neighborhoods
  # GET /neighborhoods.xml
  def index
    @neighborhoods = Neighborhood.find(:all, :order => "name")
    @preferred_neighborhood = Neighborhood.where(:id => cookies['preferred_neighborhood']).first
    
    @preferred_neighborhood_id = @preferred_neighborhood ? @preferred_neighborhood.id : nil
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @neighborhoods }
    end
  end

end
