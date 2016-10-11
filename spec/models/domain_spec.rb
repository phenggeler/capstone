require 'rails_helper'
require "spec_helper"

RSpec.describe Domain, type: :model do

let(:domain) {Domain.create(name: "test.com", uacode:'asdfasdf', pubid: 'asdfasdf')}


describe 'domain' do
 
   before(:all) do
    @domain = Domain.create(name: "indeed.com")
   end
 
    it 'will mark domain without name as invalid' do
     expect(Domain.create(name: "")).not_to be_valid
    end
    
    it 'will create new domain' do
     expect(@domain.name).to eq("indeed.com")
    end
    
    it 'will allow a domain without ua code to be created' do
     expect(@domain.name).to eq("indeed.com")
    end
    
    it 'will allow domain without pub id to be created' do
     expect(@domain.name).to eq("indeed.com")
    end
    
    it 'will catch invalid domain name' do
     expect(Domain.create(name: "asdfasdfasdf")).to be_valid
    end
    
    it 'will detect site with publisher id' do
     @domain1 = Domain.create(name: '2016election.com')
     expect(@domain1.pubid).to eq(nil)
    end
    
    it 'will find associated domains' do
     @domaintmp = Domain.create(name: 'dogville.com')
     @domains = Domain.associatedDomains(@domaintmp)
     expect(@domains.length).to be > 1
    end
    
end 

describe 'spyonweb API method calls' do
 
  before(:all) do
    uascan = Uacode.new
    pubscan = Pubcode.new
    @tmpua = Array.new
    @tmppub = Array.new
    @tmpua = uascan.pingApiForUaCode('UA-48689684', '0-24h.com')
    @tmppub = pubscan.pingApiForPub('pub-5953444431482912', 'liver-disease-symptoms.com')
  end
 
 it 'will ping Api for UA Code' do
  expect(@tmpua.length).to be > 0
 end
 
 it 'will not insert target domain into array' do
  expect(@tmpua).not_to include('0-24h.com')
 end
 
 it 'will ping Api for Pub ID' do
  expect(@tmppub).not_to include('liver-disease-symptoms.com')
 end
 
 it 'will slice www from domains' do
  @tmpua.push("www.example.com")
  expect(@tmpua).not_to include('www')
 end
end

end