class MembershipsController < ApplicationController
  before_filter :authenticate_user!, :find_group, :find_user

  def destroy
    if( @user != nil && @group != nil )

      if( @user == current_user )  # leaving a group voluntarily
        @group.remove_user(current_user)
        flash[:notice] = "You have left the #{@group.name} hub"
        redirect_to user_path(current_user)

      else  # otherwise, we are forcing another to leave the group (ie. banning)
        @group.remove_user(@user, :via_ban => true)
        flash.now[:notice] = "#{@user.email} has been banned from the #{@group.name} Hub."
        render :action => 'index'
      end

    else
      flash[:error] = "Either the requested hub does not exist or you do not have permission to perform this action."
      redirect_to user_path(current_user)
    end

  end

  def index
  end

  def new
  end

  def create
    if( @group != nil && @group.add_user(current_user) )
      flash[:notice] = "You are now a member of the #{@group.name} Hub."
      redirect_to user_path(current_user)
    else
      flash[:error] = "Unable to join that hub."
      redirect_to user_path(current_user)
    end
  end

  def find_group
    @group = Group.find_by_id(params[:group_id])
  end

  def find_user
    @user = User.find_by_id(params[:id])
  end


end

