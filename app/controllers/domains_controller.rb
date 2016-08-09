require 'rubygems'
require 'httparty'
require 'nokogiri'
require 'json'
require 'csv'
require 'open-uri'
require 'open_uri_redirections'
require 'net/http'


class DomainsController < ApplicationController
  before_action :set_domain, only: [:show, :edit, :update, :destroy]

  # GET /domains
  # GET /domains.json
  def index
    @domains = Domain.all

    
  end

  # GET /domains/1
  # GET /domains/1.json
  def show
    @domains = Array.new
    tmp = params[:id]
    tua = Domain.find(tmp).uacode
    Domain.all.each do |dom|
      if (dom.uacode.eql? tua)
      @domains.push(dom)
    end
    end
  end

  # GET /domains/new
  def new
    @domain = Domain.new
  end

  # GET /domains/1/edit
  def edit
  end

  # POST /domains
  # POST /domains.json
  def create


    str = params[:domain][:name]

    uri = URI('http://'+str)
    begin
      page = HTTParty.get(uri)
    rescue SocketError => e
      redirect_to new_domain_path, flash: {notice: "Cannot validate domain"} and return 
    end
    doc = Nokogiri::HTML(open(uri,:allow_redirections => :all))
    #this is where we transfer our http response into Nokogiri object
    parse_page = Nokogiri::HTML(page)

    #json to hash
    
    #@myhash = JSON.parse(str)
    
    doc.css('script').each do |script|
      match = nil
      tmp = nil
      txt = script.text
        if (txt =~ /.UA-[0-9]+-[0-9]+(.*)/)
          @match = txt.match(/UA-[0-9]+/)
          tmp = @match
        else
          tmp = '---'
        end
    end
    
    source = open(uri,:allow_redirections => :all).read
    arr= source.split(/\n/)
    arr.each do |st|
      if (st=~ /.-pub-(.*)/)
          @matchpub = st.match(/pub-[1-9]*/)
      end
    end

    
    darray = Array.new
    unless (@match.nil?)
      url = URI('https://api.spyonweb.com/v1/analytics/'+@match[0]+'?access_token=QpAlekatYxmO')
      doc1 = Nokogiri::HTML(open(url,:allow_redirections => :all))
      str1 =  doc1.text
      arr= str1.split(/"/)
      arr.each do |st|
          if (st.include? '.')
            if (st != str)
              darray.push(st)
            end
          end
      end
    end
    
    parray = Array.new
    unless (@match.nil?)
      url = URI('https://api.spyonweb.com/v1/adsense/'+@matchpub[0]+'?access_token=QpAlekatYxmO')
      doc1 = Nokogiri::HTML(open(url,:allow_redirections => :all))
      str1 =  doc1.text
      arr= str1.split(/"/)
      arr.each do |st|
          if (st.include? '.')
            if (st != str)
              parray.push(st)
            end
          end
      end
    end
    
    
  
    if @matchpub
        @domain = Domain.new(name: str, uacode: @match, pubid: @matchpub)
    end
    if @match
        @domain = Domain.new(name: str, uacode: @match, pubid: '---')
      else
        @domain = Domain.new(name: str, uacode: '---', pubid: '---')
    end

    darray.each do |dom|
      unless (dom == str)
        if (dom.include? "www." )
          dom.slice!("www.")
          unless (dom == str)
            @domain1 = Domain.new(name: dom, uacode: @match)
            @domain1.save
          end
        else
          @domain1 = Domain.new(name: dom, uacode: @match)
          @domain1.save
        end
      end
    end
    
    parray.each do |dom|
      unless (dom == str)
        if (dom.include? "www." )
          dom.slice!("www.")
          unless (dom == str)
            @domain1 = Domain.new(name: dom, uacode: '---', pubid: @pubid)
            @domain1.save
          end
        else
          @domain1 = Domain.new(name: dom, uacode: '---', pubid: @pubid)
          @domain1.save
        end
      end
    end
    
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

  # PATCH/PUT /domains/1
  # PATCH/PUT /domains/1.json
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

  # DELETE /domains/1
  # DELETE /domains/1.json
  def destroy
    @domain.destroy
    respond_to do |format|
      format.html { redirect_to domains_url, notice: 'Domain was successfully destroyed.' }
      format.json { head :no_content }
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
  

