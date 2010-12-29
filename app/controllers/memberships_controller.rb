class MembershipsController < ApplicationController
  before_filter :authenticate_user!, :find_group

  def destroy
    if(@group.has_member?(current_user))
      @group.remove_user(current_user)
      flash[:notice] = "You have left the #{@group.name} hub"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Either the requested hub does not exist or you do not have permission to perform this action."
      redirect_to user_path(current_user)
    end
  end

  def find_group
    @group = Group.find_by_id(params[:group_id])

    if( @group.nil? )
      flash[:error] = "Either the requested hub does not exist or you do not have permission to view it."
      redirect_to user_path(current_user)
    else
      return @group
    end
  end
end

