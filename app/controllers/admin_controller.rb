class AdminController < ApplicationController
    before_filter :authorize_admin

    def show
        @stats = Hash.new
        @stats["Events Registered"]=Event.all.count
        @stats["Users Registered"]=User.all.count
        @stats["Orgs Registered"]=Org.all.count
        @stats["Volunteer Hours"]=Participation.sum(:hours_volunteered)
        @stats["Total Volunteer Signups"]=Participation.all.count
        @stats["Volunteers per next 5 upcoming events"]=Event.upcoming.paginate(:per_page=>5, :page => 1).collect {|event| "#{event.name}: #{event.participants.count}"}

        respond_to do |format|
            format.html
            format.xml
        end
    end

    def authorize_admin
        authorize! :manage, :admin
    end
end
