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

  def index
    @watchers = Watcher.includes(:content).where(user: current_user)
  end

  def show
  end

  def new
    @watcher = Watcher.new
    respond_to do|format|
      format.html {render :new}
      format.js {render js: :new}
    end
  end

  def edit
  end

  def create
    str = params[:watcher][:domain]
    email = params[:watcher][:email]
    frequency = params[:watcher][:frequency]
    if(Parsewatcher.is_live(str))
      arr = Watcher.make_obj(str, email, frequency, current_user)
      @watcher, @content = arr[0], arr[1]
    else
      @watcher = Watcher.create(domain: str, email: email, frequency: frequency, use: 'dead', user: current_user)
      @content = Content.create_dead_content(str)
    end
    if @watcher.save
      @content.watcher_id = @watcher.id
      @content.save
      UserMailer.new_watcher_email(@watcher, @content).deliver
      respond_to do |format|
        format.html { redirect_to @watcher, notice: 'watcher was successfully created.' }
        #format.json { render json: @watcher.errors, status: :unprocessable_entity }
        format.js { redirect_to domains_path, notice: 'watcher was successfully created.' }
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
      format.html { redirect_to watchers_url, notice: 'watcher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_watcher
      @watcher = Watcher.find(params[:id])
    end

    def watcher_params
      params.require(:watcher).permit(:domain, :email, :frequency)
    end
end
