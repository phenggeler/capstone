require 'rails_helper'
require "spec_helper"

RSpec.describe Watcher, type: :model do



describe 'methods' do
    it 'will handle a new watcher object with active site' do
     @watcher = Watcher.makeObj('thedomains.com', 'peter.john.henggeler@gmail.com')
     expect(@watcher[0].domain).to eq 'thedomains.com'
    end
    
end 


end