class UserAffiliationsController < ApplicationController
  skip_authorization_check #todo suspicious

  def create
    @user = User.find_by_email(params[:user])
    @affiliate = Affiliate.find(params[:user_affiliation][:affiliate_id])
    @affiliation = UserAffiliation.find_by_user_id_and_affiliate_id(@user.id, @affiliate.id)
    @affiliation.errors[:base] << "User with e-mail address '#{params[:user]}' is already added" if @affiliation != nil
    @affiliation ||= UserAffiliation.new(params[:user_affiliation])
    @affiliation.user = @user
    @affiliation.errors[:base] << "Cannot find user with e-mail address '#{params[:user]}'" if @user == nil

    respond_to do |format|
      if !@affiliation.errors.any? && @affiliation.save
        format.html { redirect_to(affiliate_url(@affiliate), :notice => 'User added to affiliation')}
      else
        @affiliation.errors.each do |attr,msg|
          flash[:error] = msg
        end
        format.html { redirect_to(:back) }
      end
    end
  end

  def destroy
    @affiliation = UserAffiliation.find(params[:id])

    respond_to do |format|
      if @affiliation.destroy
        format.html { redirect_to(:back, :notice => 'User removed from affiliation') }
      else
        format.html { redirect_to(:back, :alert => 'Error removing user') }
      end
    end
  end
end
