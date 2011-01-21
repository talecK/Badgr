class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Either that resource does not exist or you do not have permission to access it."

    if( current_user.nil? )
      redirect_to root_path
    else
      redirect_to user_path(current_user)
    end
  end
end

