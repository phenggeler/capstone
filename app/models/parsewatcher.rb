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
    pchange = compareP(@content.p, @tcon.p)
    titlechange = compareTitle(@content.title, @tcon.title)  
    linkChange = compareLinks(@content.link, @tcon.link)
    linkTextChange = compareLinkText(@content.linktext, @tcon.linktext)
    if (pchange || titlechange || linkChange || linkTextChange)
      bigchange = true
    end
    if (bigchange)
        puts "sending email for " + watcher.domain
        UserMailer.site_change_email(@watcher, mssg).deliver
        @watcher.save
    end
      @tmp.destroy
  end
end

def compareP(w, t)
  if (!w.eql? t)
#      mssg = mssg + "P Text Has Changed"
      @watcher.p = @tmp.p
      true
  else
    false
  end
end

def compareTitle(w, t)
  if (!w.eql? t)
#    mssg = mssg + "Title Has Changed"
    @watcher.title = @tmp.title
    true
  else
    false
  end
end

def compareLinks(w, t)
  if (!w.eql? t)
#   mssg = mssg +"Number of links has changed"
    @watcher.link = @tmp.link
    true
  else
    false
  end
end

def compareLinkText(w,t)
  if (!w.eql? t)
#    mssg = mssg + "Some wording in links has changed"
    @watcher.linktext = @tmp.linktext
    true
  else
    false
  end
end

end