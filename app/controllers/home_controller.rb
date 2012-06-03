class HomeController < ApplicationController
  skip_authorization_check
  def index
  end
  def tou
    @title = "Terms Of Use"
  	respond_to do |format|
  		format.html
  	end
  end
  def privacy
    @title = "Privacy Policy"
  	respond_to do |format|
  		format.html
  	end
  end
  def partners
    @title = "Flash Volunteer Partners"
  	respond_to do |format|
  		format.html
  	end
  end
  def newsletter
    @title = "Flash Volunteer Newsletter"

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
