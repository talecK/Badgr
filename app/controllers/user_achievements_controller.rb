class UserAchievementsController < ApplicationController
	before_filter :authenticate_user!

  def new
  end

  def create
    @achievement = Achievement.find( params[:achievement_id] )

    if( @achievement != nil && current_user.achievements.create( :achievement_id => @achievement.id ) )
      flash[:notice] = "A request for the test_achievement has been sent to the officers of the #{@achievement.group.name} Hub."
    else
      flash[:error] = "Could not send a request for that achievement."
    end

    redirect_to group_achievements_path(@achievement.group)
  end
end

