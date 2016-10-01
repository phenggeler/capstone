class Parser < ApplicationRecord
    
    def self.parseSite(str)
      uri = URI('http://'+str)
     begin
        page = HTTParty.get(uri)
      rescue SocketError => e
        #redirect_to new_domain_path, flash: {notice: "Cannot validate domain"} and return 
        @watcher = Watcher.new(domain: str, email: email, use: 'dead')
        continue = false
      end
      doc = Nokogiri::HTML(open(uri,:allow_redirections => :all))
      #this is where we transfer our http response into Nokogiri object
      parse_page = Nokogiri::HTML(page)
      return parse_page
  end
  
  def self.createWatcher(str, email, parse_page)
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
        #Watcher.crawl(str)
        @watcher = Watcher.new(domain: str, url: uri, use:'live', source: nil, email: email, title: title, p: p, h1: h1, h2: h2, h3: h3, link: link, linktext: linktext, description: description, keywords: keywords)
        return @watcher
  end
end