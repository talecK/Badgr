class GemslotsController < ApplicationController
  before_filter :find_user_achievements

  def create
  end

  def edit
  end

  def show
  end

  def update
    if ( @achievement != nil && @user != nil )
      @user.gem = @achievement
      @user.save
      flash[:notice] = "Your gem has been updated"
      redirect_to user_path( @user )
    else
      flash[:error] = "Could not update Gem!"
      render :action => "edit"
    end
  end

  def find_user
    User.find( params[:user_id] )
  end

  def find_user_achievements
    @user = find_user
    @achievement = @user.achievements.find_by_id( params[:user][:gem] ) unless @user.nil? || params[:user].blank?
  end
end

