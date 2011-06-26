class FriendshipsController < ApplicationController
  before_filter :authenticate_user!

  def create
  
	if current_user.id == params[:friend_id]
		flash[:error] = "You cannot add yourself as a friend."
	else
		@friendship = current_user.has_friend?(User.find_by_id(params[:friend_id]))
		if @friendship.nil?
			@friendship = current_user.friendships.build(:friend_id => params[:friend_id], :pending => true)
			if @friendship.save
				flash[:notice] = "Friendship request sent."
			else
				flash[:error] = "Error in sending friendship request."
			end
		else
			flash[:error] = "A friendship for these users already exists."
		end
	end
	
	redirect_to user_path(params[:friend_id])
  end

  def destroy
	@friendship = Friendship.find_by_id(params[:id])
	@friendship.destroy
	flash[:notice] = "Removed friend."
	redirect_to user_friendships_path(current_user)
  end
  
  def index
	@user = User.find( params[:user_id] )
	@pending = @user.inverse_friendships.where(:pending => true)
	@my_pending = @user.friendships.where(:pending => true)
	@friends = @user.friendships.where(:pending => false) + @user.inverse_friendships.where(:pending => false)
  end
  
  def new
  end
  
  def update
	@friendship = Friendship.find_by_id(params[:id])
	if @friendship.update_attributes( :pending => false )
		flash[:notice] = "Friend added."
	else
		flash[:error] = "Error adding friend."
	end

	redirect_to user_friendships_path(current_user)
  end

end
