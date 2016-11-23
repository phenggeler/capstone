require 'rubygems'
require 'httparty'
require 'nokogiri'
require 'json'
require 'csv'
require 'open-uri'
require 'open_uri_redirections'
require 'net/http'


class Parsewatcher 
    
  def parseWatcherSite(str, email)
    uri = URI('http://'+str)
    begin
      page = HTTParty.get(uri)
    rescue SocketError => e
      @watcher = Watcher.new(domain: str, email: email, use: 'dead')
    end
  
    parse_page = Nokogiri::HTML(page)
    puri = process_uri(uri)
    doc = Nokogiri::HTML(open(puri))
    noko_objects = [parse_page, doc]
    noko_objects
  end

  def createContent(str, parse_page)
    uri = URI('http://' +str)
    h = {
      'domain' => str,
      'url' => uri,
      'use' => 'live',
      'source' => get_source(parse_page),
      'sum' => get_sum(parse_page),
      'title' => get_title(parse_page),
      'p' => get_p(parse_page),
      'h1' => get_h1(parse_page),
      'h2' => get_h2(parse_page),
      'h3' => get_h3(parse_page),
      'link' => get_link(parse_page),
      'linktext' => get_linktext(parse_page),
      'description' => get_description(doc),
      'keywords' => get_keywords(doc)
    }
    @content = Content.new(h)
  end

  def get_keywords(doc)
    doc.xpath("//meta[@name='keywords']/@content").text.split(", ")
  end
  
  def get_description(doc)
    doc.xpath("//meta[@name='description']/@content").text
  end
  
  def get_linktext(parse_page)
    parse_page.css('a').text
  end
  
  def get_link(parse_page)
    parse_page.css('a').length
  end
  
  def get_h3(parse_page)
    parse_page.css('h3').text
  end
  
  def get_h2(parse_page)
    parse_page.css('h2').text
  end
  
  def get_h1(parse_page)
    parse_page.css('h1').text
  end
  
  def get_p(parse_page)
    parse_page.css('p').text
  end
  
  def get_sum(parse_page)
    parse_page.text.sum
  end
  
  def get_source(parse_page)
    parse_page.text
  end
  
  def get_title(parse_page)
    parse_page.css('title').text
  end
  
  def current?(watcher, content)
    @watcher = watcher
    @content = content
    arr = Watcher.makeObj(@watcher.domain, 'fake@fake.com', 'minutes', User.last)
    @tmp = arr[0]
    @tcon = arr[1]
    mssg = []
    bigchange = false
    
    if (!@content.sum.eql? @tcon.sum)
      unless @content.p.eql? @tcon.p
        mssg.push("Some generic P text on the page has changed")
        pChange = true
      end
      
      unless @content.title.eql? @tcon.title
        mssg.push("The title of the page has changed")
        titleChange = true
      end
      unless @content.link.eql? @tcon.link
        mssg.push("The number of links on the page has changed")
        linkChange = true
      end
      unless @content.linktext.eql? @tcon.linktext
        mssg.push("The link text on the page has changed")
        linkTextChange = true
      end
      if (pChange || titleChange || linkChange || linkTextChange)
        bigchange = true
      end
      if (bigchange)
          puts "sending email for " + watcher.domain
          UserMailer.site_change_email(@watcher, mssg).deliver
          @watcher = arr[0]
          @content = @tcon
          @watcher.save
          @content.save
      end
      @tmp.destroy
    end
  end
  
  private

  def process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :all) do |r|
      r.base_uri.to_s
    end
  end

end