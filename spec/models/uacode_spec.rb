require 'rails_helper'
require "spec_helper"

RSpec.describe Uacode, type: :model do



describe 'populate' do
    it 'will remove wwww from list' do
        x = Uacode.remove_www('www.markmonitor.com')
        expect(x).to eq ('markmonitor.com')
    end
    
    it 'will populate arrays' do 
      uacode = Uacode.new
      darray = ['cnn.com', 'thedomains.com', 'markmonitor.com']
      str = 'thedomains.com'
      c = Domain.count
      m = 'UA-523453'
      uacode.populate(darray, str, m, User.last)
      expect(Domain.count).to be > c
    end
    
end 


end