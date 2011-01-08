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

end

