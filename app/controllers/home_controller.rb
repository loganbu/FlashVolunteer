class HomeController < ApplicationController
  skip_authorization_check
  def index
  end
  def tou
  	respond_to do |format|
  		format.html
  	end
  end
  def privacy
  	respond_to do |format|
  		format.html
  	end
  end
  def partners
  	respond_to do |format|
  		format.html
  	end
  end

  def newsletter
    respond_to do |format|
      format.html
      format.xml  { head :ok }
    end
  end
  def sadface
    respond_to do |format|
      format.html
    end
  end
end
