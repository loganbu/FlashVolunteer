class Users::FollowersController < ApplicationController
    load_and_authorize_resource :user

    # Show the "prop this user" form
    # /users/{my_id}/followers/{to_follow}
    def update
        @me = User.find_by_id(params[:user_id])
        @me.errors.add(:follower_id, "Error following user") if current_user != @me

        @following = User.find_by_id(params[:id])
        @me.errors.add(:follower_id, "Error following user") if @following == @me || @following == nil

        @me.following << @following

        respond_to do |format|
            if @me.save
                format.html # new.html.erb
                format.xml  { render :xml => @me }
            else
                format.html { render :action => "update" }
                format.xml  { render :xml => @me.errors, :status => :unprocessable_entity }
            end
        end
    end

    # Prop the user
    def destroy
        @me = User.find_by_id(params[:user_id])
        @me.errors.add(:follower_id, "Error following user") if current_user != @me

        @following = User.find_by_id(params[:id])
        @me.errors.add(:follower_id, "Error following user") if @following == @me || @following == nil

        @me.following.delete(@following)

        respond_to do |format|
          if @me.save
            format.html { redirect_to(:back, :notice => "You are no longer following #{@following.name}") }
            format.xml  { head :ok }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @me.errors, :status => :unprocessable_entity }
          end
        end
    end
end
