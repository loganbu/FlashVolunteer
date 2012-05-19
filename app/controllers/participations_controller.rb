class ParticipationsController < ApplicationController
  include SessionsHelper
  skip_authorization_check

  # PUT /participation
  def update
    @event = Event.find(params[:id])
    @participation = @event.participations.find_by_user_id(current_user.id)
    hours_volunteered = params[:hours_volunteered]
    error = nil
    if (hours_volunteered.to_i.hours > @event.duration)
      error = "You cannot volunteer for more hours than the event lasted"
    elsif (hours_volunteered.to_i == 0)
      error = "Hours volunteered must be greater than 0"
    else
      @participation.hours_volunteered = hours_volunteered
      @participation.save!
    end
    respond_to do |format|
      format.html { redirect_to(:back, :flash => {:error => error}) }
    end
  end

  def destroy

  end

end
