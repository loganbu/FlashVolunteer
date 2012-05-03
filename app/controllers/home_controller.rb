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
  def about
  	respond_to do |format|
  		format.html
  	end
  end
  def partners
  	respond_to do |format|
  		format.html
  	end
  end
end
