class Users::NotificationsController < ApplicationController
  load_and_authorize_resource :user
  
  def show
    @user = User.includes(:user_notifications).find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if (params[:user] == nil)
      @user.notification_preferences = []
    end
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'Your profile was successfully updated.') }
        format.mobile { redirect_to(@user, :notice => 'Your profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
end
