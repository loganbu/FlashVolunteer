class Users::PropsController < ApplicationController
    load_and_authorize_resource :user

    # Show all the props given to this user
    def index
        @given = Prop.given_by(current_user)
        @received = Prop.received_by(current_user)
    end

    # Show the "prop this user" form
    # /users/{receiver}/prop
    def new
        @prop = Prop.new
        @prop.receiver = User.find_by_id(params[:id])

        respond_to do |format|
          format.html # new.html.erb
          format.xml  { render :xml => @prop }
        end
    end

    # Prop the user
    def create
        @prop = Prop.new
        @prop.receiver = User.find_by_id(params[:id])
        @prop.giver = current_user
        @prop.message = params[:prop][:message]

        respond_to do |format|
          if @prop.save
            format.html { redirect_to(@prop.receiver, :notice => 'Thanks for the prop') }
            format.xml  { render :xml => @prop, :status => :created }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @prop.errors, :status => :unprocessable_entity }
          end
        end
    end
end
