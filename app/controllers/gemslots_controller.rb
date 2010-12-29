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
      @user.gemslot.achievement = @achievement
      flash[:notice] = "Your gem has been updated"
      redirect_to user_path( @user )
    else
      flash[:error] = "Could not update Gem!"
      render :action => "edit"
      @user.gemslot.save
    end
  end

  def find_user
    User.find( params[:user_id] )
  end

  def find_user_achievements
    @user = find_user
    @achievement = @user.achievements.find_by_id( params[:gemslot][:id] ) unless @user.nil? || params[:gemslot].blank?
  end
end

