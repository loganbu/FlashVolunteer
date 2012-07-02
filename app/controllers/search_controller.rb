class SearchController < ApplicationController
  skip_authorization_check

  def show
    search_term = "%#{params[:search]}%"
    @events = Event.where('name LIKE ?', search_term).limit(10)
    @orgs = Org.where('name LIKE ? or email like ?', search_term, search_term).limit(10)
    @users = User.where('name LIKE ? or email like ?', search_term, search_term).limit(10)
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @orgs }
    end
  end

end
