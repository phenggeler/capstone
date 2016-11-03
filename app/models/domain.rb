class Domain < ApplicationRecord
  attr_reader :associated
  attr_accessor :associated
  validates :name, :uniqueness  => {:scope=>:user_id}
  validates :name, presence: true
  belongs_to :user
  
  def self.makeObj(str, current_user)
    ids = parse_for_codes(str)
    @matchpub = ids[0]
    @match = ids[1]
    task = AssociationBuilder.new
    task.create_related_domains(@match, @matchpub, str, current_user)
    @domain = Domain.new(name: str, uacode: @match, pubid: @matchpub, user: current_user)
    return @domain
  end
  
  def self.parse_for_codes(str)
    parser = Parsedomain.new
    parse_page = parser.parseSite(str)
    ids = parser.findCodes(parse_page)
    return ids
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
