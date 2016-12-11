$LOAD_PATH << '.'
require 'nokogiri_parser'

class Content < ApplicationRecord
  include NokogiriParser
  belongs_to :watcher
  
  
  def self.create_content(str, parse_page)
    @content = Content.new
    @content.update_attributes(@content.generate_hash(parse_page, str))
    @content
  end
  
  def self.create_dead_content(str)
    @content = Content.new
    @content.update_attributes(@content.dead_hash(str))
    @content
  end
  
end
