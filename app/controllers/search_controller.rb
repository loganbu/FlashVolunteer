class SearchController < ApplicationController
  skip_authorization_check

  def show
    search_term = "%#{params[:search]}%"
    @events = Event.where('name LIKE ?', search_term).limit(10)
    @orgs = Org.where('name LIKE ? or email LIKE ?', search_term, search_term).limit(10)
    @users = User.where('name LIKE ? or email LIKE ?', search_term, search_term).limit(10)
    @help_articles = HelpArticle.where('title LIKE ? or description LIKE ?', search_term, search_term).limit(10)
    
    query = Search.new(:query => params[:search], :orgs_found => @orgs.count, :users_found=>@users.count, :events_found=>@events.count, :help_articles_found => @help_articles.count)
    query.save
    
    respond_to do |format|
      format.html
    end
  end

end
