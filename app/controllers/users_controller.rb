class UsersController < ApplicationController
	before_filter :authenticate_user!
	
  def new
  end
	
	def index
		@user_email = current_user.email
	end

end
