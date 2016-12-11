
class DomainsController < ApplicationController
  before_action :set_domain, only: [:show, :edit, :update, :destroy]

  def index
    if !logged_in?
      redirect_to new_user_session_path, alert: 'Please login first.'
    end
    @domains = Domain.includes(:user).where(user: current_user)
  end

  def show
    if !logged_in?
      redirect_to new_user_session_path, alert: 'Please login first.'
    end
    tmp = params[:id]
    @domains = Domain.associated_domains(tmp)
  end
  
  def facebook
  end

  def new
    @domain = Domain.new
  end

  def edit
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


  def destroy
    @domain.destroy
    respond_to do |format|
        format.js 
    end
  end
  
  def new_watcher
    @watcher = Watcher.new
    @domain = Domain.find(params[:domain_id])
    respond_to do |format|
        format.js 
    end
  end

private
  
  def set_domain
    @domain = Domain.find(params[:id])
  end

  def domain_params
    params.require(:domain).permit(:name, :uacode)
  end
  
end
