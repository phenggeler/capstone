require 'rails_helper'
require "spec_helper"

RSpec.describe Watcher, type: :model do



describe 'methods' do
    it 'will handle a new watcher object with active site' do
     @watcher = Watcher.make_obj('thedomains.com', 'peter.john.henggeler@gmail.com', 'hours', User.last)
     expect(@watcher[0].domain).to eq 'thedomains.com'
    end
    
end 


end