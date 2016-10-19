require 'httparty'
require 'nokogiri'
require 'json'
require 'csv'
require 'open-uri'
require 'open_uri_redirections'
require 'net/http'

class Watcher < ApplicationRecord
  belongs_to :author
  has_one :content, dependent: :destroy
  #belongs_to :contents, dependent: :destroy
  @list_of_urls = Array.new
  @email = nil

def self.makeObj(str, email, frequency, current_user)
  parser = Parsewatcher.new
  parse_page = parser.parseWatcherSite(str, email)
  @watcher = Watcher.new
  @watcher.domain = str
  @watcher.email = email
  @watcher.author = current_user
  @watcher.frequency = frequency
  @watcher.lastscanned = Time.new
  @content = parser.createContent(str, parse_page)
  arr = []
  arr.push(@watcher)
  arr.push(@content)
  return arr
end



end
