require 'rails_helper'
require "spec_helper"

RSpec.describe Uacode, type: :model do



describe 'populate' do
    it 'will remove wwww from list' do
        x = Uacode.removeWWW('www.markmonitor.com')
        expect(x).to eq ('markmonitor.com')
    end
    
end 


end