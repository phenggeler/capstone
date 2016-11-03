    class Api::V1::DomainsController < Api::V1::BaseController
      before_action :authenticate_user!
      
      def index
        domains = Domain.all
        render json: domains, status: 200   # this format can be important!
      end

      def show
        domain = Domain.find(params[:id])
        render json: domain, status: 200
      end
    end