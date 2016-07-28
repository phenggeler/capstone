require 'rubygems'
require 'httparty'
require 'nokogiri'
require 'json'
require 'pry'
require 'csv'
require 'rkelly'
require 'open-uri'
require 'open_uri_redirections'
require 'net/http'


#this is how we request the page we are going to scrape

@domains = Domain.all
puts @domains
#Pry.start(binding)


#parse_page.css('.javascript') do |a|
#    post_name = a.text
#    ua_array.push(post_name)
#end

