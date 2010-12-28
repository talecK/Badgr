class GemslotsController < ApplicationController
  before_filter :find_user_achievements

  def create
    # if we have the parameters we want
    if ( !params[:gemslot].blank? && !params[:gemslot][:gem].blank? )
      file_path = Rails.root.to_s + '/public' + params[:gemslot][:gem]
      @user.gemslot.gem = File.open( file_path )

      # if gem was assigned to a valid file and successfully saved to the database
      if( @user.gemslot.save && @user.gemslot.gem.exists? )
        flash[:notice] = "Your gem has been updated"
        redirect_to user_path( @user )
      else
        flash[:error] = "Could not update Gem!"
        render :action => "edit"
      end

    else
      flash[:error] = "Could not update Gem!"
      render :action => "edit"
    end
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
    @achievement = Achievement.find( params[:gemslot][:id] ) unless @user.nil? || params[:gemslot].blank?
  end
end

