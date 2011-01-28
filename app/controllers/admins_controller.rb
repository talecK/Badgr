class AdminsController < ApplicationController
  before_filter :authenticate_user!
  load_resource :group

  def index
  end
end

