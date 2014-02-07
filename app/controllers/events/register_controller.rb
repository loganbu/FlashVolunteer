class Events::RegisterController < ApplicationController
  skip_authorization_check

  def create
    @event = Event.find(params[:id])
      
    unless anyone_signed_in?
      session[:sign_up_for_event] = @event.id
      session[:signup_reason] = :register_event
      send_to_quick_signup(event_url(@event))
      return
    end

    if (@event.can_register?)
        @event.participants << current_user if !@event.participants.include?(current_user)
        flash[:popup] = "We have successfully signed you up for #{@event.name}! We'll send you an email reminder the day before and will notify the coordinator."
    else
        flash[:error] = 'Sorry, the event is full, try again next time!'
    end

    respond_to do |format|
      format.html { redirect_to(event_url(@event)) }
      format.xml  { render :xml => @event, :status => :created, :location => @event }
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.participants.delete(current_user)

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end
end
