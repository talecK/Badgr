class AchievementsController < ApplicationController
  before_filter :find_group

  def index
  end

  def new
    @achievement = Achievement.new
  end

  def create
    @user = find_user

    if @group != nil && @user != nil
      @achievement = @group.achievements.build( params[:achievement] )
      @achievement.creator = @user
      @achievement.save!
      flash[:notice] = "Achievement was successfully created."
      redirect_to group_path(@group)
    else
      flash[:alert] = "Unable to create Achievement!"
      render :action => "new"
    end
  end

  def find_group
    @group = Group.find( params[:group_id] )
  end

  def find_user
    @user = User.find( params[:user_id] )
  end
end

