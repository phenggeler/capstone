require 'rails_helper'
require "spec_helper"

RSpec.describe Parsedomain, type: :model do



describe 'findcodes' do
    it 'will handle a domain with pubid' do
     parser = Parsedomain.new
     parse_page = parser.parseSite('snotr.com')
     @ids = parser.findCodes(parse_page)
     expect(@ids[0]).to eq 'pub-9689722798762145'
    end
    
end 


end