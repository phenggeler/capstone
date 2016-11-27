require 'rails_helper'
require "spec_helper"

RSpec.describe Content, type: :model do



describe 'content creation' do
    it 'will handle a new watcher object with dead site' do
     @content = Content.create_dead_content('asdfasdfsd.com')
     expect(@content.use).to eq 'dead'
    end
end 


end