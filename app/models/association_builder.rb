class AssociationBuilder
  
  def create_related_domains(match, matchpub, str, current_user)
      @match = match
      @matchpub = matchpub
      @ping = ApiPing.new
      @populator = Populator.new
      darray = populate_darray(@match, str, current_user)
      parray = populate_parray(@matchpub, str, current_user)
  end
  
  def populate_darray(match, str, current_user)
    darray = []
    @match = match
    
    unless (@match.nil?)
      darray = @ping.pingApiForCode(@match, str, 'analytics')
      @populator.populate(darray, str, @match, @matchpub, current_user)
    end
    
    return darray
  end
  
  def populate_parray(matchpub, str, current_user)
    parray = []
    @matchpub = matchpub
    
    unless (@matchpub.nil?)
      parray = @ping.pingApiForCode(@matchpub[0], str, 'adsense')
      @populator.populate(parray, str, @match, @matchpub[0], current_user)
    end
    
    return parray
  end
end