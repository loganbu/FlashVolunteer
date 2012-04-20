class ParticipationsController < ApplicationController
  include SessionsHelper
  skip_authorization_check

  # PUT /participation
  def update
    @event = Event.find(params[:id])
    @participation = @event.participations.find_by_user_id(current_user.id)
    @participation.hours_volunteered = params[:hours_volunteered]
    @participation.save!
    respond_to do |format|
      format.html { redirect_to(:back) }
    end
  end

  def destroy

  end

end
