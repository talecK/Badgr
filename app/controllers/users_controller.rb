class UsersController < ApplicationController
	before_filter :authenticate_user!
	
  def new
  end

	def index
	end
end
