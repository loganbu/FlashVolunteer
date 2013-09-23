class AffiliatesController < ApplicationController
  load_and_authorize_resource

  def index
    @affiliates = Affiliate.all.select{|a| can? :manage, a}

    respond_to do |format|
      format.html
    end
  end

  def new
    @affiliate = Affiliate.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @affiliate = Affiliate.new(params[:affiliate])

    respond_to do |format|
      if @affiliate.save
        format.html { redirect_to(affiliates_url, :notice => 'Affiliate was successfully created.') }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  def update
    @affiliate = Affiliate.find(params[:id])

    respond_to do |format|
      if @affiliate.update_attributes(params[:affiliate])
        format.html { redirect_to(affiliates_url, :notice => 'Affiliate was successfully updated.') }
      else
        format.html { render :action => 'edit' }
      end
    end
  end

  def edit
    @affiliate = Affiliate.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def show
    @affiliation = UserAffiliation.new
    @affiliate = Affiliate.find(params[:id])
    @affiliation.affiliate = @affiliate

    respond_to do |format|
      format.html
    end
  end
end
