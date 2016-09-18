class Domain < ApplicationRecord
    attr_reader :associated
    attr_accessor :associated
    validates_uniqueness_of :name
    belongs_to :author
end
