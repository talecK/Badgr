class UsersController < ApplicationController
	before_filter :authenticate_user!

  def new
  end

	def index
		@user = current_user
	end

	def show
		@user = current_user
	end

  def edit
    @user = User.find( params[:id] )
  end

  def update
    @user = User.find( params[:id] )
    puts params
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

