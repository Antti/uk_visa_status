class ApplicationController < ActionController::Base
  protect_from_forgery
  def check_authentication
    redirect_to new_user_session_path unless current_user
  end
end
