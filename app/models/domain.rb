class Domain < ApplicationRecord
  attr_reader :associated
  attr_accessor :associated
  validates_uniqueness_of :name
  validates :name, presence: true
  belongs_to :author
  
  def self.makeObj(str, current_user)
    
    ids = call_find_codes(str)
    @matchpub = ids[0]
    @match = ids[1]
    create_related_domains(@match, @matchpub, str, current_user)
    @domain = Domain.new(name: str, uacode: @match, pubid: @matchpub, author: current_user)
    
    return @domain
  end
  
  def self.create_related_domains(match, matchpub, str, current_user)
    @match = match
    @matchpub = matchpub
    darray = populate_darray(@match, str, current_user)
    parray = populate_parray(@matchpub, str, current_user)
  end
  
  def self.call_find_codes(str)
    parser = Parsedomain.new
    parse_page = parser.parseSite(str)
    ids = parser.findCodes(parse_page)
    return ids
  end
  
  def self.populate_darray(match, str, current_user)
    darray = []
    @match = match
    unless (@match.nil?)
      uascan = Uacode.new
      darray = uascan.pingApiForUaCode(@match, str)
      uascan.populate(darray, str, @match, current_user)
    end
    return darray
  end
  
  def self.populate_parray(matchpub, str, current_user)
    parray = []
    @matchpub = matchpub
    unless (@matchpub.nil?)
      pubscan = Pubcode.new
      parray = pubscan.pingApiForPub(@matchpub[0], str)
      pubscan.populate(parray, str, @matchpub[0], current_user)
    end
    return parray
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
