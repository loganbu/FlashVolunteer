class HelpArticlesController < ApplicationController
  skip_authorization_check
  
  def index
    @articles = HelpArticle.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.mobile
      format.xml  { render :xml => @neighborhoods }
    end
  end
end
