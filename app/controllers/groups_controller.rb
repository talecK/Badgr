class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    @group.save!
    @group.add_creator( current_user )

    flash[:notice] = "Group has been created!"
    redirect_to (user_path( current_user ) )
  end

  def show
    @group = Group.find(params[:id])
  end

  def index
    @groups = Group.all
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
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

