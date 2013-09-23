class Orgs::UsersController < ApplicationController
  load_and_authorize_resource :org

  def index
    @org = Org.find(params[:org_id])
    authorize_org_profile(@org)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @org }
    end
  end

  def create
    @org = Org.find(current_user.id)
    @user = User.first(:conditions => [ 'lower(email) = ?', params[:email].downcase ])

    if @user == nil
      flash[:error] = 'That email address does not match any Flash Volunteer users. Please try again.'
    else
      unless @org.admins.include?(@user)
        @org.admins << @user
      end

      if @user.save
        flash[:notice] = "#{@user.email} now an admin of #{@org.name}."
        if Rails.env.production?
          # send the e-mail
          UserMailer.delay.new_org_admin(@org, @user)
        else
          UserMailer.new_org_admin(@org, @user).deliver
        end
      else
        @user.errors.each do |_,msg|
          flash[:error] = msg
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to :back}
      format.xml  { render :xml => @org }
    end
  end

  def update
    @org = Org.find(params[:org_id])
    @admin = User.find(params[:id])

    unless @org.admins.include?(@admin)
      @org.admins << @admin
    end
    respond_to do |format|
      format.html { redirect_to(:back, :notice => "#{@admin.name} is now an admin of #{@org.name}.") }
      format.xml  { render :xml => @org }
    end
  end

  def destroy
    @org = Org.find(params[:org_id])
    @admin = User.find(params[:id])

    if @org.admins.count > 1
      @org.admins.delete(@admin)
      flash[:notice] = "#{@admin.name} is no longer an admin of #{@org.name}."
    else
      flash[:alert] = 'You cannot remove your last admin'
    end
    
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { render :xml => @org }
    end
  end
end
