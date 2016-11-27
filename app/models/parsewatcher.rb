require 'rubygems'
require 'httparty'
require 'nokogiri'
require 'json'
require 'csv'
require 'open-uri'
require 'open_uri_redirections'
require 'net/http'


class Parsewatcher 
  
  
  def self.is_live(str)
    uri = URI('http://'+str)
    begin
      page = HTTParty.get(uri, { timeout: 5 })
      return true
    rescue => e
      return false
    end
  end
    
  def parse_watcher_site(str, email)
    uri = URI('http://'+str)
    begin
      page = HTTParty.get(uri, { timeout: 5 })
    rescue => e
      return
    end
    parse_page = Nokogiri::HTML(page)
    puri = process_uri(uri)
    doc = Nokogiri::HTML(open(puri))
    noko_objects = [parse_page, doc]
    noko_objects
  end

  def current?(watcher, content)
    @watcher = watcher
    @content = content
    arr = Watcher.make_obj(@watcher.domain, 'fake@fake.com', 'minutes', User.last)
    @tmp = arr[0]
    @tcon = arr[1]
    mssg = []
    bigchange = false
    
    if (!@content.sum.eql? @tcon.sum)
      
      unless @content.use.eql? @tcon.use
        mssg.push("The site had been dead. It is now live.")
        pChange = true
      end
      
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
          @watcher = @tmp
          @watcher.update_attribute(:use, @tmp.use)
          @tcon.save
          h = Parsewatcher.create_hash(@tcon)
          @content.update_attributes(h)
          @watcher.save
          @content.save
      end
    end
    
      @tmp.destroy
      @tcon.destroy
  end
  
  def self.create_hash(tcon)
    h = {
      'use' => tcon.use, 
      'source' => tcon.source, 
      'sum' => tcon.sum, 
      'title' => tcon.title, 
      'p' => tcon.p, 
      'h1' => tcon.h1, 
      'h2' => tcon.h2, 
      'h3' => tcon.h3, 
      'link' => tcon.link, 
      'linktext' => tcon.linktext, 
      'description' => tcon.description, 
      'keywords' => tcon.keywords
    }
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