class Api::V1::WatchersController < Api::V1::BaseController

    before_action :authenticate_user!
    before_filter :find_watcher, only: [:show, :edit, :update, :destroy]


  def index
    watchers = Watcher.all
    render json: watchers, status: 200   # this format can be important!
  end

  def show
    domain = Watcher.find(params[:id])
    render json: domain, status: 200
  end

  def new
    @watcher = Watcher.new
  end
  
  def create
    str = params[:watcher][:domain]
    email = params[:watcher][:email]
    frequency = params[:watcher][:frequency]
    if(Parsewatcher.is_live(str))
      arr = Watcher.makeObj(str, email, frequency, current_user)
      @watcher, @content = arr[0], arr[1]
    else
      @watcher = Watcher.create(domain: str, email: email, frequency: frequency, use: 'dead', user: current_user)
      @content = Content.create_dead_content(str)
    end
    respond_to do |format|
      if @watcher.save
        @content.watcher_id = @watcher.id
        @content.save
        UserMailer.new_watcher_email(@watcher, @content).deliver
        format.html { redirect_to @watcher, notice: 'watcher was successfully created.' }
        format.json { render :show, status: :created, location: @watcher }
      else
        format.html { render :new }
        format.json { render json: @watcher.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @watcher.update(watcher_params)
        format.html { redirect_to @watcher, notice: 'watcher was successfully updated' }
        format.json { render :show, status: :ok, location: @watcher }
      else
        format.html { render :edit }
        format.json { render json: @watcher.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @watcher.destroy
    respond_to do |format|
      format.json { render json: {status: "Watcher ID #{@watcher.id} deleted"}, status: :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_watcher
      @watcher = Watcher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def watcher_params
      params.require(:watcher).permit(:domain, :email, :frequency)
    end
    
    def find_watcher
      @watcher = Watcher.find(params[:id])
    end
    
end