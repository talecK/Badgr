class UserAchievementsController < ApplicationController
	before_filter :authenticate_user!

  def new
     @achievement = Achievement.find( params[:achievement_id] )
     @user_achievement = current_user.user_achievements.build( :achievement_id => @achievement.id ) if @achievement != nil
  end

  def create
    @achievement = Achievement.find( params[:achievement_id] )
    @user_achievement = current_user.user_achievements.build( :status => :pending, :achievement_id => @achievement.id ) if @achievement != nil

    if( @user_achievement != nil && @user_achievement.save)
      flash[:notice] = "A request for the test_achievement has been sent to the officers of the #{@achievement.group.name} Hub."
    else
      flash[:error] = "Either that Achievement no longer exists or we could not send a request for that achievement."
    end

    redirect_to group_achievements_path( @achievement.group )
  end
end

