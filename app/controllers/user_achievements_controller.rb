class UserAchievementsController < ApplicationController
	before_filter :authenticate_user!
	load_resource :group, :only => [:update, :show, :index]
	load_resource :achievement, :only => [:new, :create]
	load_resource :only => [:show, :update]

  def new
    authorize! :request_achievement, @achievement
    @user_achievement = current_user.user_achievements.build( :achievement_id => @achievement.id ) if @achievement != nil
  end

  def show
    authorize! :update, @group
  end

  def update
    authorize! :award, @user_achievement

    if( @group != nil && @user_achievement != nil )
      if(params[:commit] == "Award")
        @user_achievement.present_by(current_user)
        flash[:notice] = "You have awarded #{@user_achievement.user.email} the '#{@user_achievement.achievement.name}' achievement."
      else
        flash[:error] = "Either that Achievement no longer exists or we could not send a request for that achievement."
      end

    else
      flash[:error] = "Either that Achievement no longer exists or we could not send a request for that achievement."
      redirect_to user_path(current_user)
    end

    redirect_to group_user_achievements_path(@group)
  end

  def index
    authorize! :update, @group

    # for each user in the group, add its user achievements
    @user_achievements = Array.new
    @group.users.each { |user| @user_achievements << user.user_achievements }
    @user_achievements.flatten!
  end

  def create
    authorize! :request_achievement, @achievement

    if( current_user.request_achievement( @achievement ) )
      flash[:notice] = "A request for the test_achievement has been sent to the officers of the #{@achievement.group.name} Hub."
      redirect_to group_achievements_path( @achievement.group )
    else
      flash[:error] = "Either that Achievement no longer exists or we could not send a request for that achievement."
      redirect_to user_path( current_user )
    end
  end

end

