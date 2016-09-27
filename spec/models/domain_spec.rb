require 'rails_helper'
require "spec_helper"

RSpec.describe Domain, type: :model do

let(:domain) {Domain.create(name: "test.com", uacode:'asdfasdf', pubid: 'asdfasdf')}


describe 'domain' do
    it 'will mark domain without name as invalid' do
     expect(Domain.create(name: "")).not_to be_valid
    end
    
    it 'will mark domain with name as valid' do
     expect(Domain.create(name: "test.com")).to be_valid
    end
    
    it 'will mark domain without ua code as valid' do
     expect(Domain.create(name: "test.com")).to be_valid
    end
    
    it 'will mark domain without pub id as valid' do
     expect(Domain.create(name: "test.com")).to be_valid
    end
    
    it 'will catch invalid domain name' do
     expect(Domain.create(name: "asdfasdfasdf")).to be_valid
    end
    
    it 'will detect site with publisher id' do
     @domain1 = Domain.create(name: '2016election.com')
     expect(@domain1.pubid).to eq(nil)
    end
    
    it 'will detect similar sites' do
     @domain = Domain.create(name: 'dogville.com')
     @domains = Domain.associatedDomains(@domain)
     expect(@domains.length).to eq(1)
    end
end 


end