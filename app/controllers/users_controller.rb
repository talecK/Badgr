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
      @feed_items = @user.feed.feed_items.accessible_by(current_ability, :read )
      @feed = @user.feed
    else
		  @user = current_user
		  @feed = @user.feed
		  @feed_items = @user.feed.feed_items.accessible_by(current_ability, :read )
    end

	  @friendship = Friendship.find_by_user_id_and_friend_id(current_user.id, params[:id])
	  if @friendship.nil?
		  @friendship = Friendship.find_by_user_id_and_friend_id(params[:id], current_user.id)
	  end
	  @pending = current_user.inverse_friendships.where(:pending => true)

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

