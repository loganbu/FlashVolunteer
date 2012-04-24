class HomeController < ApplicationController
  skip_authorization_check
  def index
  end

  def demo
    @event = Event.find_by_name("UW Business Plan Competition")
    redirect_to checkin_event_url(@event)
  end
end
