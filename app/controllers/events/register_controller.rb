class Events::RegisterController < ApplicationController    
  skip_authorization_check

  load_and_authorize_resource :only => :destroy


  # POST /events/1/register
  def create
    @event = Event.find(params[:id])
      
    if (!current_user)
      redirect_to(quick_new_user_url)
      return
    end
	
    @event.participants << current_user
    
    respond_to do |format|
      if true
        flash[:popup] = "We have successfully signed you up for " + @event.name + "! We'll send you an email reminder the day before and will notify the coordinator."
        format.html { redirect_to(@event) }
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
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
end
