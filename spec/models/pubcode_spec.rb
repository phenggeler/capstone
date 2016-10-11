require 'rails_helper'
require "spec_helper"

RSpec.describe Pubcode, type: :model do



describe 'populate' do
    it 'will remove wwww from list' do
        x = Pubcode.removeWWW('www.markmonitor.com')
        expect(x).to eq ('markmonitor.com')
    end
    
    it 'will populate the array' do
        author = Author.new
        parray = []
        parray.push('thedomains.com')
        parray.push('lendingclub.com')
        parray.push('nelnet.com')
        p = Pubcode.new
        p.populate(parray, 'sample.com', 'sample', author)
        expect(Domain.last.name).to eq 'nelnet.com'
    end
    
end 


end