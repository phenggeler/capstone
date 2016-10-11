class ContentsController < ApplicationController

 before_action :set_content, only: [:show, :edit, :update, :destroy]
#  before_filter :zero_watchers_or_authenticated, only: [:new, :create]



  # GET /watchers
  # GET /watchers.json
  def index
    @contents = Content.all
  end

  # GET /watchers/1
  # GET /watchers/1.json
  def show
  end

  # GET /watchers/new
  def new
    @content = Content.new
  end

  # GET /watchers/1/edit
  def edit
  end

  # POST /watchers
  # POST /watchers.json
  def create

    respond_to do |format|
      if @content.save
        format.html { redirect_to @watcher, notice: 'watcher was successfully created.' }
        format.json { render :show, status: :created, location: @watcher }
      else
        format.html { render :new }
        format.json { render json: @watcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /watchers/1
  # PATCH/PUT /watchers/1.json
  def update
    respond_to do |format|
      if @content.update(watcher_params)
        format.html { redirect_to @watcher, notice: 'watcher was successfully updated.' }
        format.json { render :show, status: :ok, location: @watcher }
      else
        format.html { render :edit }
        format.json { render json: @watcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /watchers/1
  # DELETE /watchers/1.json
  def destroy
    @content.destroy
    respond_to do |format|
      format.html { redirect_to watchers_url, notice: 'watcher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def watcher_params
      #params.require(:watcher).permit(:username, :email, :password, :password_confirmation)
    end
end
