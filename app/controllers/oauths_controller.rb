class OauthsController < ApplicationController
  skip_filter :require_login

  
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
    else
      begin
Rails.logger.info "***************************"
Rails.logger.info "line #{__LINE__}"
        @user = create_from(provider)
Rails.logger.info "line #{__LINE__}"
#        @user.activate!
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule
Rails.logger.info "line #{__LINE__}"
        reset_session # protect from session fixation attack
Rails.logger.info "line #{__LINE__}"
        auto_login(@user)
Rails.logger.info "line #{__LINE__}"

        redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
      rescue StandardError => e
Rails.logger.info e
        redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
      end
    end
  end
  #example for Rails 4: add private method below and use "auth_params[:provider]" in place of 
  #"params[:provider] above.

   private
   def auth_params
     params.permit(:code, :provider)
   end
  
  
end
