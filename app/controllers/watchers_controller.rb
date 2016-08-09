require 'rubygems'
require 'httparty'
require 'nokogiri'
require 'json'
require 'csv'
require 'open-uri'
require 'open_uri_redirections'
require 'net/http'

class WatchersController < ApplicationController
  before_action :set_watcher, only: [:show, :edit, :update, :destroy]
#  before_filter :zero_watchers_or_authenticated, only: [:new, :create]



  # GET /watchers
  # GET /watchers.json
  def index
    @watchers = Watcher.all
  end

  # GET /watchers/1
  # GET /watchers/1.json
  def show
  end

  # GET /watchers/new
  def new
    @watcher = Watcher.new
  end

  # GET /watchers/1/edit
  def edit
  end

  # POST /watchers
  # POST /watchers.json
  def create
    #@watcher = Watcher.new(watcher_params)
    
    str = params[:watcher][:domain]
    email = params[:watcher][:email]
    uri = URI('http://'+str)
    begin
      page = HTTParty.get(uri)
    rescue SocketError => e
      redirect_to new_domain_path, flash: {notice: "Cannot validate domain"} and return 
    end
    doc = Nokogiri::HTML(open(uri,:allow_redirections => :all))
    #this is where we transfer our http response into Nokogiri object
    parse_page = Nokogiri::HTML(page)
    

    @watcher = Watcher.new(domain: str, source: doc.text, email: email)

    
    respond_to do |format|
      if @watcher.save
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
      if @watcher.update(watcher_params)
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
    @watcher.destroy
    respond_to do |format|
      format.html { redirect_to watchers_url, notice: 'watcher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_watcher
      @watcher = Watcher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def watcher_params
      #params.require(:watcher).permit(:username, :email, :password, :password_confirmation)
    end
end
