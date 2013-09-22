class Events::RegisterController < ApplicationController
  skip_authorization_check

  # POST /events/1/register
  def create
    @event = Event.find(params[:id])
      
    if (!anyone_signed_in?)
      session[:sign_up_for_event] = @event.id
      session[:signup_reason] = :register_event
      send_to_quick_signup(event_url(@event))
      return
    end

    @event.participants << current_user if !@event.participants.include?(current_user)
    
    respond_to do |format|
      if true
        flash[:popup] = "We have successfully signed you up for " + @event.name + "! We'll send you an email reminder the day before and will notify the coordinator."
        format.html { redirect_to(event_url(@event)) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1/register
  def destroy
    @event = Event.find(params[:id])
    @event.participants.delete(current_user)

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end
end
