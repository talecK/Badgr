class UsersController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource

  def new
  end

	def index
		@users = User.all
	end

	def show
	  if(params[:id])
      @feed = @user.feed
    else
		  @user = current_user
		  @feed = @user.feed
    end
	end

  def edit
  end

  def update
    if @user.update_attributes( params[:user] )
      flash[:notice] = "Profile has been updated"
      redirect_to user_path( @user )
    else
      flash[:error] = "Could not update profile!"
      render :action => "edit"
      @user.save
    end
  end
end

