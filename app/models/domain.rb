class Domain < ApplicationRecord
    attr_reader :associated
    attr_accessor :associated
    validates_uniqueness_of :name
    validates :name, presence: true
    belongs_to :author
    
    def self.makeObj(str, current_user)
      x = 'http://'.concat(str)
      uri = URI('http://'+str)
      begin
        page = HTTParty.get(uri)
      rescue SocketError => e
      redirect_to new_domain_path, flash: {notice: "Cannot validate domain"} and return 
      end
    doc = Nokogiri::HTML(open(uri,:allow_redirections => :all))
    #this is where we transfer our http response into Nokogiri object
    parse_page = Nokogiri::HTML(page)
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
        
        if (txt=~ /.pub-[0-9](.*)/)
          @matchpub = txt.match(/pub-[0-9]*/)
        end
    end
    source = open(uri,:allow_redirections => :all).read
    arr= source.split(/\n/)
    arr.each do |st|
      if (st=~ /.-pub-(.*)/)
          #@matchpub = st.match(/pub-[1-9]*/)
      end
    end
    darray = Array.new
    unless (@match.nil?)
      darray = pingApiForUaCode(@match[0], str)
    end
    
    parray = Array.new
    unless (@matchpub.nil?)
      parray = pingApiForPub(@matchpub[0], str)
    end
    
    
  
    if @matchpub
        @domain = Domain.new(name: str, uacode: @match, pubid: @matchpub, author: current_user)
    end
    if @match
        @domain = Domain.new(name: str, uacode: @match, pubid: @matchpub, author: current_user)
      else
        @domain = Domain.new(name: str, uacode: '---', pubid: @matchpub, author: current_user)
    end

    darray.each do |dom|
      unless (dom == str)
        if (dom.include? "www." )
          removeWWW(dom, str, current_user)
        else
          @domain1 = Domain.new(name: dom, uacode: @match, author: current_user)
          @domain1.save
        end
      end
    end
    
    parray.each do |dom|
      unless (dom == str)
        if (dom.include? "www." )
          removeWWW(dom, str, current_user)
        else
          @domain1 = Domain.new(name: dom, uacode: '---', pubid: @pubid, author: current_user)
          @domain1.save
        end
      end
    end
    return @domain
    end
    
    def self.associatedDomains(tmp)
      @domain = tmp
      @domains = Array.new
      tua = Domain.find(@domain).uacode
      Domain.all.each do |dom|
        if (dom.uacode.eql? tua)
        @domains.push(dom)
        end
      end
      return @domains
    end
    
    def self.pingApiForPub(mp, str)
      parray = Array.new
      url = URI('https://api.spyonweb.com/v1/adsense/'+mp+'?access_token=QpAlekatYxmO')
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
      return parray
    end
    
    def self.pingApiForUaCode(m, str)
      darray = Array.new
      url = URI('https://api.spyonweb.com/v1/analytics/'+m+'?access_token=QpAlekatYxmO')
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
      return darray
    end
    
    def self.removeWWW(dom, str, current_user)
      dom.slice!("www.")
      unless (dom == str)
        @domain1 = Domain.new(name: dom, uacode: '---', pubid: @pubid, author: current_user)
        @domain1.save
      end
    end
end
