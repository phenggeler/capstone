require 'httparty'
require 'nokogiri'
require 'json'
require 'csv'
require 'open-uri'
require 'open_uri_redirections'
require 'net/http'

class Watcher < ApplicationRecord
  belongs_to :user
  has_one :content, dependent: :destroy

  
  scope :by_user, -> { joins(:user) }


  def self.make_obj(str, email, frequency, current_user)
    parser = Parsewatcher.new
    noko_objects = parser.parse_watcher_site(str, email)
    parse_page, doc = noko_objects[0], noko_objects[1]
    @watcher = Watcher.new
    @watcher.domain = str
    @watcher.email = email
    @watcher.user = current_user
    @watcher.frequency = frequency
    @watcher.lastscanned = Time.new
    @watcher.use = 'live'
    @content = Content.create_content(str, parse_page)
    arr = [@watcher, @content]
    arr
  end
end
