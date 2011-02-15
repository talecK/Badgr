class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def new
    @group = Group.new
  end

  def create
    @group.save!
    @group.add_creator( current_user )

    flash[:notice] = "Group has been created!"
    redirect_to (user_path( current_user ) )
  end

  def show
    @feed = @group.feed
  end

  def index
    @groups = Group.all
  end

  def edit
  end

  def update
    if @group.update_attributes( params[:group] )
      flash[:notice] = "#{@group.name} Hub has been updated."
      redirect_to group_path( @group )
    else
      flash[:error] = "Could not update Hub!"
      render :action => "edit"
      @group.save
    end
  end
end

