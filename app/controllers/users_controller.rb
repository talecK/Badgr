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

end

