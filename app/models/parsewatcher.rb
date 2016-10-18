class Parsewatcher 
    
def parseWatcherSite(str, email)
  uri = URI('http://'+str)
  begin
    page = HTTParty.get(uri)
  rescue SocketError => e
    #redirect_to new_domain_path, flash: {notice: "Cannot validate domain"} and return 
    @watcher = Watcher.new(domain: str, email: email, use: 'dead')
    continue = false
  end
  #doc = Nokogiri::HTML(open(uri,:allow_redirections => :all))
  #this is where we transfer our http response into Nokogiri object
  parse_page = Nokogiri::HTML(page)
  return parse_page
end

def createContent(str, parse_page)
  uri = URI('http://' +str)
  title = parse_page.css('title').text
  h1 = parse_page.css('h1').text
  h2 = parse_page.css('h2').text
  h3 = parse_page.css('h3').text
  p = parse_page.css('p').text
  link = parse_page.css("a").length
  linktext = parse_page.css("a").text
  description = parse_page.xpath('//meta[@name="Description"]/@content').text
  keywords = parse_page.xpath('//meta[@name="Keywords"]/@content').text
  source = parse_page.text
  sum = source.sum
  #Watcher.crawl(str)
  @content = Content.new(domain: str, url: uri, use:'live', source: source, sum: sum, title: title, p: p, h1: h1, h2: h2, h3: h3, link: link, linktext: linktext, description: description, keywords: keywords)
  return @content
end
  
def current?(watcher, content)
  @watcher = watcher
  @content = content
  arr = Watcher.makeObj(@watcher.domain, 'fake@fake.com')
  @tmp = arr[0]
  @tcon = arr[1]
  mssg = 'not complete'
  bigchange = false
  
  if (!@content.sum.eql? @tcon.sum)
    puts 'content ' + @content.sum.to_s
    puts 'content ' + @tcon.sum.to_s
    
    pchange = compareP(@content.p, @tcon.p, @content)
    titlechange = compareTitle(@content.title, @tcon.title, @content)  
    linkChange = compareLinks(@content.link, @tcon.link, @content)
    linkTextChange = compareLinkText(@content.linktext, @tcon.linktext, @content)
    if (pchange || titlechange || linkChange || linkTextChange)
      bigchange = true
    end
    if (bigchange)
        puts "sending email for " + watcher.domain
        UserMailer.site_change_email(@watcher, mssg).deliver
        @watcher = arr[0]
        @content = @tcon
        @watcher.save
        @content.save
    end
      @tmp.destroy
  end
end

def compareP(w, t, content)
    @content = content

  if (!w.eql? t)
#      mssg = mssg + "P Text Has Changed"
      true
  else
    false
  end
end

def compareTitle(w, t, content)
    @content = content

  if (!w.eql? t)
#    mssg = mssg + "Title Has Changed"
    true
  else
    false
  end
end

def compareLinks(w, t, content)
    @content = content

  if (!w.eql? t)
#   mssg = mssg +"Number of links has changed"
    true
  else
    false
  end
end

def compareLinkText(w,t, content)
  @content = content
  if (!w.eql? t)
#    mssg = mssg + "Some wording in links has changed"
    true
  else
    false
  end
end

end