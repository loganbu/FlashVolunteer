class HomeController < ApplicationController
  def index
    @users = User.all
    @events = Event.all
    @orgs = Org.all
  end
end
