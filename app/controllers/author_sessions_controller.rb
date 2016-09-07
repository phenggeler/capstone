class AuthorSessionsController < ApplicationController
    
  def new
  end

  def create
    if (!Author.verified?(params[:email]))
        flash[:alert] = 'You are Not Verified Yet'
        redirect_to(new_author_session_path)
    else
      if login(params[:email], params[:password])
        flash[:notice] = 'Logged In Successfully'
        redirect_back_or_to(authors_path)
      else
        flash.now.alert = "Login failed."
        render action: :new
      end
    end
  end

  def destroy
    logout
    redirect_to(new_author_session_path, notice: 'Logged out!')
  end
  end
