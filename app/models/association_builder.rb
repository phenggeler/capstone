class AssociationBuilder
    
  def create_related_domains(match, matchpub, str, current_user)
      @match = match
      @matchpub = matchpub
      darray = populate_darray(@match, str, current_user)
      parray = populate_parray(@matchpub, str, current_user)
  end
  
  def populate_darray(match, str, current_user)
      darray = []
      @match = match
      
      unless (@match.nil?)
        uascan = Uacode.new
        darray = uascan.pingApiForUaCode(@match, str)
        uascan.populate(darray, str, @match, current_user)
      end
      
      return darray
  end
  
  def populate_parray(matchpub, str, current_user)
    parray = []
    @matchpub = matchpub
    
    unless (@matchpub.nil?)
      pubscan = Pubcode.new
      parray = pubscan.pingApiForPub(@matchpub[0], str)
      pubscan.populate(parray, str, @matchpub[0], current_user)
    end
    
    return parray
  end
end