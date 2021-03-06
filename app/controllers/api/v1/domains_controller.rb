class Api::V1::DomainsController < Api::V1::BaseController
  before_action :authenticate_user!
  before_filter :find_domain, only: [:show, :edit, :update, :destroy]

  def index
    domains = Domain.all
    render json: domains, status: 200   # this format can be important!
  end

  def show
    domain = Domain.find(params[:id])
    render json: domain, status: 200
  end
  
  def create
    str = params[:domain][:name]
    @domain = Domain.make_obj(str, current_user)
    @domain.user = current_user

    respond_to do |format|
      if @domain.save
        format.html { redirect_to @domain, notice: 'Domain was successfully created.' }
        format.json { render :show, status: :created, location: @domain }
      else
        format.html { render :new }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
   @domain.destroy
    respond_to do |format|
      #format.html { redirect_to domains_url, notice: 'Domain was successfully destroyed.' }
      #format.js 
      #format.json { head :no_content }
      format.json { render json: {status: "Domain ID #{@domain.id} deleted"}, status: :ok }
    end
  end
  
  def update
    respond_to do |format|
      if @domain.update(domain_params)
        format.html { redirect_to @domain, notice: 'Domain was successfully updated.' }
        format.json { render :show, status: :ok, location: @domain }
      else
        format.html { render :edit }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      @domain = Domain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def domain_params
      params.require(:domain).permit(:name, :uacode)
    end
    
    def find_domain
      @domain = Domain.find(params[:id])
    end
  

end