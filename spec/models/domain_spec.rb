require 'rails_helper'
require "spec_helper"

RSpec.describe Domain, type: :model do

let(:item) {Item.create(name: "FirstItem", description: "big description")}
let(:categorywords) {['one', 'two words', 'three']}
#Item tag list be comma separated
#Item tag list will include all its tags


end