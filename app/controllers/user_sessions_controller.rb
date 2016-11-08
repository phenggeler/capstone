class UserSessionsController < ApplicationController
    
  def new
  end

  def create
    if (User.count > 0 && !User.verified?(params[:email]))
        flash[:alert] = 'This is not a verified account'
        redirect_to(new_user_session_path)
    else
      if login(params[:email], params[:password])
        flash[:notice] = 'Logged In Successfully'
        redirect_back_or_to(domains_path)
      else
        flash.now.alert = "Login failed."
        render action: :new
      end
    end
  end

  def destroy
    logout
    redirect_to(new_user_session_path, notice: 'Logged out!')
  end
end
