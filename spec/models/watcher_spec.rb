require 'rails_helper'
require "spec_helper"

RSpec.describe Watcher, type: :model do



describe 'methods' do
    it 'will handle a new watcher object with active site' do
     @watcher = Watcher.makeObj('thedomains.com', 'peter.john.henggeler@gmail.com')
     expect(@watcher).to be_valid
    end
    
    it 'will handle a new watcher object with dead site' do
     @watcher = Watcher.makeObj('peterjohnhenggelerdoesnotexist.com', 'peter.john.henggeler@gmail.com')
     expect(@watcher).to be_valid
    end
    
    it 'can check that content has not changed' do
     @watcher = Watcher.makeObj('thedomains.com', 'peter.john.henggeler@gmail.com')
     expect(@watcher.worthScanning?(@watcher)).to be(false)
    end
    
    it 'can check that content has changed' do
     @watcher = Watcher.makeObj('thedomains.com', 'peter.john.henggeler@gmail.com')
     @watcher.domain = 'markmonitor.com'
     expect(@watcher.worthScanning?(@watcher)).to be(false)
    end
    
    it 'can check if content has changed' do
     @watcher = Watcher.makeObj('thedomains.com', 'peter.john.henggeler@gmail.com')
     @tmp = Watcher.makeObj('markmonitor.com', 'peter.john.henggeler@gmail.com')
     expect(@watcher.current?(@tmp)).to be(false)
    end
end 


end