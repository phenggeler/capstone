class Api::V1::BaseController < ApplicationController

  skip_before_action :verify_authenticity_token  # turn off CSRF checking

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :malformed_request

  attr_reader :current_user   # optional, but you might like having it, you can always use @current_user if you don't anyway

  def authenticate_user!   # remember ApplicationController calls this already!
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(api_auth_token: token)
    end
  end

  def authorize_user
    unless @current_user   # and whatever other conditions you might want...
      render json: { error: "Not Authorized", status: 403}, status: 403
    end
  end

  def malformed_request
    error_msg = "The request was not understood.  Please adjust the request before re-trying."
    render json: { error: error_msg, status: 400}, status: 400 # :bad_request
  end

  def record_not_found
    render json: { error: "Record not found", status: 404}, status: 404 # :not_found
  end
end