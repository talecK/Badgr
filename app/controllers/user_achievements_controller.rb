class UserAchievementsController < ApplicationController
	before_filter :authenticate_user!, :find_achievement

  def new
    authorize! :request_achievement, @achievement
    @user_achievement = current_user.user_achievements.build( :achievement_id => @achievement.id ) if @achievement != nil
  end

  def create

    if( current_user.request_achievement( @achievement ) )
      flash[:notice] = "A request for the test_achievement has been sent to the officers of the #{@achievement.group.name} Hub."
      redirect_to group_achievements_path( @achievement.group )
    else
      flash[:error] = "Either that Achievement no longer exists or we could not send a request for that achievement."
      redirect_to user_path( current_user )
    end
  end

  def find_achievement
    @achievement = Achievement.find( params[:achievement_id] )
  end
end

