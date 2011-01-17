class AchievementsController < ApplicationController
  before_filter :find_group

  def index
  end

  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = Achievement.new( params[:achievement] )

    if @achievement.save && @group != nil
      @group.achievements << @achievement
      flash[:notice] = "Achievement was successfully created."
      redirect_to group_path(@group)
    else
      flash[:alert] = "Achievement has not been created."
      render :action => "new"
    end
  end

  def find_group
    @group = Group.find( params[:group_id] )
  end
end

