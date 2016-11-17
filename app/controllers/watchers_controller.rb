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
  end

  def edit
  end

  def create
    str = params[:watcher][:domain]
    email = params[:watcher][:email]
    frequency = params[:watcher][:frequency]
    arr = Watcher.makeObj(str, email, frequency, current_user)
    @watcher = arr[0]
    @content = arr[1]

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
