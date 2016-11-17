class AssociationBuilder
  
  def create_related_domains(ids, builder)
    @matchpub, @match = ids[0], ids[1]
    @ping = ApiPing.new
    @populator = Populator.new
    populate_darray(@match, builder)
    populate_parray(@matchpub, builder)
  end
  
  def populate_darray(match, builder)
    darray = []
    @match = match
    unless (@match.nil?)
      darray = @ping.pingApiForCode(@match, builder[0], 'analytics')
      @populator.populate(darray, @match, @matchpub, builder)
    end
  end
  
  def populate_parray(matchpub, builder)
    parray = []
    @matchpub = matchpub
    unless (@matchpub.nil?)
      parray = @ping.pingApiForCode(@matchpub[0], builder[0], 'adsense')
      @populator.populate(parray, @match, @matchpub[0], builder)
    end
  end
  
end