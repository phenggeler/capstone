require 'rails_helper'
require "spec_helper"

RSpec.describe Parsewatcher, type: :model do

let(:parser) {Parsewatcher.new}

let (:watcher) {Watcher.create(domain: 'cnn.com', email: 'peter.john.henggeler@gmail.com')}
let (:content) {Content.create(domain: 'test', url: 'test', use:'live', source: 'test', sum: 'test', title: 'test', p: 'test', h1: 'test', h2: 'test', h3: 'test', link: 0, linktext: 'test', description: 'test', keywords: 'test')}
let (:watcher2) {Watcher.create(domain: 'thedomains.com', email: 'peter.john.henggeler@gmail.com')}



describe 'current? comparisons' do
    it 'will update title current?' do
      parser = Parsewatcher.new
      parse_page = parser.parseWatcherSite('cnn.com', "fake@fake.com")
      content = parser.createContent('cnn.com', parse_page )
      watcher.content_id = content.id
      tmp = 'else'
      parser.current?(watcher,content)
      expect(content.title).not_to eq tmp
    end
    
    it 'will update title current?' do
      parser = Parsewatcher.new
      parse_page = parser.parseWatcherSite('cnn.com', "fake@fake.com")
      content = parser.createContent('cnn.com', parse_page )
      watcher.content_id = content.id
      tmp = 'else'
      parser.current?(watcher2,content)
      expect(content.title).not_to eq tmp
    end
    
    
end

describe 'parse watcher site' do
    it 'will return parse_page' do
      parse = Parsewatcher.new
      parse_page = parser.parseWatcherSite('cnn.com', "fake@fake.com")
      expect(parse_page).not_to be nil
    end
end
end