class Parsedomain

  def parseSite(str)
    uri = URI('http://'+str)
    begin
      page = HTTParty.get(uri)
    rescue SocketError => e
      #redirect_to new_domain_path, flash: {notice: "Cannot validate domain"} and return 
    end
    parse_page = Nokogiri::HTML(page)
    return parse_page
  end

  def findCodes(parse_page)
    ids = []
    if (parse_page.to_s=~ /.pub-[0-9]*/)
      @matchpub = parse_page.to_s.match(/pub-[0-9]*/)
      ids.push(@matchpub[0])
    else
      ids.push(nil)
    end
    if (parse_page.to_s=~ /.UA-[0-9]+-[0-9]+(.*)/)
      @match = parse_page.to_s.match(/UA-[0-9]+/)
      ids.push(@match[0])
    else
      ids.push(nil)
    end
    return ids
  end
    
end