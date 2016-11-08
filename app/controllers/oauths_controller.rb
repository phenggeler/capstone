class OauthsController < ApplicationController
  skip_filter :require_login
  
  
  def oauth
    login_at(params[:provider])
  end
  
  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_to domains_path, :notice => "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to domains_path, :notice => "Logged in from #{provider.titleize}!"
      rescue StandardError => e
        redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
      end
    end
  end
  
   private
   def auth_params
     params.permit(:code, :provider)
   end
  
  
end
