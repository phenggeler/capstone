require 'rails_helper'
require "spec_helper"

RSpec.describe Populator, type: :model do



describe 'populate' do
    it 'will remove wwww from list' do
        x = Populator.removeWWW('www.markmonitor.com')
        expect(x).to eq ('markmonitor.com')
    end
end 


end