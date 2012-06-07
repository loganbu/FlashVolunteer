class AdminController < ApplicationController
    before_filter :authorize_admin

    def show
        @stats = Hash.new
        @stats["Events Registered"]=Event.all.count
        @stats["Users Registered"]=User.all.count
        @stats["Orgs Registered"]=Org.all.count
        @stats["Volunteer Hours"]=Participation.sum(:hours_volunteered)
        @stats["Props Given"]=Prop.all.count
        @stats["Most Propped Users"]=Prop.select("receiver_id, count(*) as props").group("receiver_id").order('props desc').collect do |result|
            if (result.receiver_id)
                user = User.find_by_id(result.receiver_id)
                "#{result.props} - #{user.name}"
            end
        end
        @stats["Total Volunteer Signups"]=Participation.all.count
        @stats["Volunteers per next 5 upcoming events"]=Event.upcoming.paginate(:per_page=>5, :page => 1).collect {|event| "#{event.id} #{event.name}: #{event.participants.count}"}
        
        respond_to do |format|
            format.html
            format.xml
        end
    end

    def authorize_admin
        authorize! :manage, :admin
    end
end
