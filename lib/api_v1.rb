module Api_v1
  class API < Grape::API
    prefix "api"
    version 'v1', :using=> :path
 
    resource "events" do
      get do
        Event.all
      end

      get "/search" do
        per_page = params[:per_page] || 5
        proximity = params[:proximity] || ((params[:lat] || params[:long]) ? 5 : 100)
        
        lat_long = (params[:lat] && params[:long]) ? [params[:lat].to_f, params[:long].to_f] : [47.618777, -122.33139]
        @events = Event.includes(:skills).where("1=1").near(lat_long, proximity)
        
        id_array = params[:id] && params[:id].split(',') || []
        categories_array = params[:categories] && params[:categories].split(',') || []

        created_by_array = params[:created_by] && params[:created_by].split(',') || []
        participated_by_array = params[:participated_by] && params[:participated_by].split(',') || []

        # This probably sucks at scale, need to test.  Makes "name=blah" into a SQL statement of LIKE %BLAH%
        name_array = params[:name] && params[:name].split(',').collect{ |x| "%" + x + "%"} || []

        if (params.key? :upcoming)
          num_days_future = (params[:upcoming] && params[:upcoming].to_i) || false
          @events = @events.upcoming(num_days_future)
        end
        if (params.key? :past)
          num_days_past = (params[:past] && params[:past].to_i) || false
          @events = @events.past(num_days_past)
        end

        # begin with an an association that's always true
        @events = id_array.length > 0 ? @events.where{id.eq_any id_array} : @events
        @events = categories_array.length > 0 ? @events.joins(:skills).where{skills.id.eq_any categories_array} : @events
        @events = name_array.length > 0 ? @events.where{name.matches_any name_array} : @events
        @events = created_by_array.length > 0 ? @events.where{creator_id.eq_any created_by_array} : @events
        @events = participated_by_array.length > 0 ? @events.joins(:participants).where{participations.user_id.eq_any participated_by_array} : @events
        @events = @events.paginate(:page=>params[:page], :per_page => per_page)
        @events
      end

      get ':id' do
        Event.find(params[:id])
      end


    end

    resource "users" do
      get do
        User.all
      end

      get "/search" do
        per_page = params[:per_page] || 5

        id_array = params[:id] && params[:id].split(',') || []
        email_array = params[:email] && params[:email].split(',') || []
        categories_array = params[:categories] && params[:categories].split(',') || []
        team_array = params[:on_team] && params[:on_team].split(',') || []

        # begin with an an association that's always true
        @users = User.where("1=1")
        
        @users = id_array.length > 0 ? @users.where{id.eq_any id_array} : @users
        @users = email_array.length > 0 ? @users.where{email.eq_any email_array} : @users
        @users = categories_array.length > 0 ? @users.joins(:skills).where{skills.id.eq_any categories_array} : @users
        @users = team_array.length > 0 ? @users.joins(:followers).where{users_followers.follower_id.eq_any team_array} : @users
        @users = @users.paginate(:page=>params[:page], :per_page => per_page)
        @users
      end

      get ':id' do
        User.find(params[:id])
      end
    end

    resource "neighborhoods" do
      get do
        Neighborhood.all
      end
    end
  end
end