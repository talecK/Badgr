class AchievementsController < ApplicationController
  before_filter :authenticate_user!
  load_resource :group
  authorize_resource :group, :only => :index
  respond_to :html, :json, :only => :show

  def show
    @achievement = @group.achievements.find( params[:id] )
    respond_with( @achievement )
  end

  def index
  end

  def new
    authorize! :create_achievements, @group
    @achievement = Achievement.new
  end

  def create
    authorize! :create_achievements, @group
    @achievement = @group.achievements.build( params[:achievement] )
    @achievement.creator = current_user

    if @achievement.save!
      flash[:notice] = "Achievement was successfully created."
      redirect_to group_path(@group)
    else
      fail_and_redirect
    end
  end

  def fail_and_redirect
    flash[:alert] = "Unable to create Achievement!"
    render :action => "new"
  end
end

