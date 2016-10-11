class Domain < ApplicationRecord
    attr_reader :associated
    attr_accessor :associated
    validates_uniqueness_of :name
    validates :name, presence: true
    belongs_to :author
    
    def self.makeObj(str, current_user)
      
    
    parser = Parsedomain.new
    parse_page = parser.parseSite(str)
    ids = parser.findCodes(parse_page)
    puts ids[0]
    puts ids[1]
    @matchpub = ids[0]
    @match = ids[1]

    
    darray = []
    unless (@match.nil?)
      uascan = Uacode.new
      darray = uascan.pingApiForUaCode(@match, str)
      uascan.populate(darray, str, @match, current_user)
    end
    
    parray = []
    unless (@matchpub.nil?)
      pubscan = Pubcode.new
      parray = pubscan.pingApiForPub(@matchpub[0], str)
      pubscan.populate(parray, str, @matchpub[0], current_user)
    end
    
 
    @domain = Domain.new(name: str, uacode: @match, pubid: @matchpub, author: current_user)
  
#    if @matchpub
#        @domain = Domain.new(name: str, uacode: @match, pubid: @matchpub, author: current_user)
#    end
    #can you simpliy this to shorter line by making uacode one variable?
#    if @match
#        @domain = Domain.new(name: str, uacode: @match, pubid: @matchpub, author: current_user)
#      else
#        @domain = Domain.new(name: str, uacode: '---', pubid: @matchpub, author: current_user)
#    end
    
    return @domain
    end
    
    def self.associatedDomains(tmp)
      @domain = tmp
      @domains = Array.new
      tua = Domain.find(@domain).uacode
      Domain.all.each do |dom|
        if (dom.uacode.eql? tua)
        @domains.push(dom)
        end
      end
      return @domains
    end
end
