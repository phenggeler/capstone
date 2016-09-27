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
    unless (@matchpub.nil?)
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
          dom.slice!("www.")
          unless (dom == str)
            @domain1 = Domain.new(name: dom, uacode: @match, author: current_user)
            @domain1.save
          end
        else
          @domain1 = Domain.new(name: dom, uacode: @match, author: current_user)
          @domain1.save
        end
      end
    end
    
    parray.each do |dom|
      unless (dom == str)
        if (dom.include? "www." )
          dom.slice!("www.")
          unless (dom == str)
            @domain1 = Domain.new(name: dom, uacode: '---', pubid: @pubid, author: current_user)
            @domain1.save
          end
        else
          @domain1 = Domain.new(name: dom, uacode: '---', pubid: @pubid, author: current_user)
          @domain1.save
        end
      end
    end
    return @domain
    end
    
    def self.associatedDomains(tmp)
    @domains = Array.new
    tua = Domain.find(tmp).uacode
    Domain.all.each do |dom|
      if (dom.uacode.eql? tua)
      @domains.push(dom)
      end
    end
    return @domains
    end
end
