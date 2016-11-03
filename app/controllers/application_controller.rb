class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  
  private
  def require_login
    if !logged_in?
      redirect_to new_user_session_path
      flash[:alert] = "You need to be signed in"
    end
  end
end
