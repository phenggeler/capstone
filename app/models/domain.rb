class Domain < ApplicationRecord
  attr_reader :associated
  attr_accessor :associated
  validates :name, :uniqueness  => {:scope=>:user_id}
  validates :name, presence: true
  belongs_to :user
  
  scope :by_user, -> { joins(:user) }

  
  def has_watcher
    Watcher.where(domain: name).where(user_id: user_id).count > 0
  end
  
  def self.make_obj(str, current_user)
    ids = parse_for_codes(str)
    @matchpub, @match = ids[0], ids[1]
    task = AssociationBuilder.new
    builder = [str, current_user]
    task.create_related_domains(ids, builder)
    @domain = Domain.new(name: str, uacode: @match, pubid: @matchpub, user: current_user)
    @domain
  end
  
  def self.parse_for_codes(str)
    parser = Parsedomain.new
    parse_page = parser.parse_site(str)
    ids = parser.find_codes(parse_page)
    ids
  end
  
  def self.associated_domains(tmp)
    @domain = tmp
    @domains = Array.new
    tua = Domain.find(@domain).uacode
    Domain.all.each do |dom|
      if (dom.uacode.eql? tua)
        @domains.push(dom)
      end
    end
    @domains
  end
end
