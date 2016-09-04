require 'rails_helper'

RSpec.describe DomainsController, type: :controller do


    
    it "succeeds" do
        get :index # experiment
        expect(response).to be_success # verification            
    end
    
end
