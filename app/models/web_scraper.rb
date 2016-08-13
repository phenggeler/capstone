require 'rubygems'
require 'httparty'
require 'nokogiri'
require 'json'
require 'pry'
require 'csv'
require 'open-uri'
require 'open_uri_redirections'
require 'net/http'


#this is how we request the page we are going to scrape

 
         uri = URI('http://'+'markmonitor.com')

        begin
          page = HTTParty.get(uri)
        rescue SocketError => e
          #redirect_to new_domain_path, flash: {notice: "Cannot validate domain"} and return 
        end
        doc = Nokogiri::HTML(open(uri,:allow_redirections => :all))
        #this is where we transfer our http response into Nokogiri object
        parse_page = Nokogiri::HTML(page)
        doc = Nokogiri::HTML(open(uri,:allow_redirections => :all))

        #puts parse_page.css('title').text
        #puts parse_page.css('h2')
        #puts parse_page.css('body').text
        parse_page.xpath("//text()").text
        parse_page.css('h2').each do |h2|
            #puts h2.text
        end
        
        parse_page.css('h3').each do |h3|
            #puts h3.text
        end
        puts parse_page.css('p').text
        parse_page.css("a").text
        #puts links.length
        links.each do |link|
          if (!link['href'].to_s.include? 'markmonitor.com')
            #puts link['href']
          end
        end
        #puts doc.xpath('//meta[@name="Description"]/@content').text
        #puts doc.xpath('//meta[@name="Keywords"]/@content').textrails 