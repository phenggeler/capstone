require 'httparty'
require 'nokogiri'
require 'json'
require 'csv'
require 'open-uri'
require 'open_uri_redirections'
require 'net/http'

class Watcher < ApplicationRecord
  
  
      belongs_to :author
      
      @list_of_urls = Array.new
      @email = nil



    def self.makeObj(str, email)
      @email = email
      parse_page = Parser.parseSite(str)
      #parse_page = Nokogiri::HTML(page)
      @watcher = Parser.createWatcher(str, email, parse_page)
      return @watcher
    end
    
    def worthScanning?(watcher)
      bigchange = false
      @watcher = watcher
      @tmp = Watcher.makeObj(@watcher.domain, 'fake@fake.com')
      mssg = ''
      bigchange = false
      if (!@watcher.source.eql? @tmp.source)
        bigchange = true
      end
      return bigchange
    end
   
    def current?(watcher)
        #pass emails
        @watcher = watcher
        @tmp = Watcher.makeObj(@watcher.domain, 'fake@fake.com')
        mssg = ''
        bigchange = false
        if (!@watcher.source.eql? @tmp.source)
            if (!@watcher.p.eql? @tmp.p)
              mssg = mssg + "P Text Has Changed"
              @watcher.p = @tmp.p
              bigchange = true
            end
            if (!@watcher.title.eql? @tmp.title)
              mssg = mssg + "Title Has Changed"
              @watcher.title = @tmp.title
              bigchange = true
            end
            if (!@watcher.link.eql? @tmp.link)
              mssg = mssg +"Number of links has changed"
              @watcher.link = @tmp.link
              bigchange = true
            end
            if (!@watcher.linktext.eql? @tmp.linktext)
              mssg = mssg + "Some wording in links has changed"
              @watcher.linktext = @tmp.linktext
              bigchange = true
            end
            if (bigchange)
              UserMailer.site_change_email(@watcher, mssg).deliver
              @watcher.save
            end
            @tmp.destroy
        end
        return bigchange
    end
end
