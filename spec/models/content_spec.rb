require 'rails_helper'
require "spec_helper"
require 'nokogiri_parser'


RSpec.configure do |c|
  c.include NokogiriParser
end

RSpec.describe Content, type: :model do

describe 'content creation' do
    it 'will handle a new watcher object with dead site' do
     @content = Content.create_dead_content('asdfasdfsd.com')
     expect(@content.use).to eq 'dead'
    end
    
    it 'will create a new live watcher' do
      parser = Parsewatcher.new
      parse_page = parser.parse_watcher_site('cnn.com', "fake@fake.com")[0]
      content = Content.create_content('cnn.com', parse_page )       
      expect(content.use).to eq 'live'
    end
    
        
  it "can generate_hash" do
    parser = Parsewatcher.new
    parse_page = parser.parse_watcher_site('cnn.com', "fake@fake.com")[0]
    @content = Content.new
    @content.include(NokogiriParser)
    h = @content.generate_hash(parse_page, 'cnn.com')
  end

end 


end