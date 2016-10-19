class Content < ApplicationRecord
  belongs_to :watcher
  
    def self.createContent(str, parse_page)
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
  
end
