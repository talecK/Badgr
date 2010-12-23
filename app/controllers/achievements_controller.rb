class AchievementsController < ApplicationController
  before_filter :find_user

  def index
  end

  def find_user
    @user = User.find( params[:user_id] )
  end

end

