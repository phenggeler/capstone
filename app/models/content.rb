class Content < ApplicationRecord
  belongs_to :watcher
  
  
  def self.create_content(str, parse_page)
    uri = URI('http://' +str)
    h = {
      'domain' => str,
      'url' => uri,
      'use' => 'live',
      'source' => get_source(parse_page),
      'sum' => get_sum(parse_page),
      'title' => get_title(parse_page),
      'p' => get_p(parse_page),
      'h1' => get_h1(parse_page),
      'h2' => get_h2(parse_page),
      'h3' => get_h3(parse_page),
      'link' => get_link(parse_page),
      'linktext' => get_linktext(parse_page),
      'description' => get_description(parse_page),
      'keywords' => get_keywords(parse_page)
    }
    #@content = Content.new(domain: str, url: uri, use:'live', source: source, sum: sum, title: title, p: p, h1: h1, h2: h2, h3: h3, link: link, linktext: linktext, description: description, keywords: keywords)
    @content = Content.new(h)
    @content
  end
  
  def self.create_dead_content(str)
    uri = URI('http://' +str)
    title = ""
    h1 = ""
    h2 = ""
    h3 = ""
    p = ""
    link = 0
    linktext = ""
    description = ""
    keywords = ""
    source = ""
    sum = 0
    @content = Content.new(domain: str, url: uri, use:'dead', source: source, sum: sum, title: title, p: p, h1: h1, h2: h2, h3: h3, link: link, linktext: linktext, description: description, keywords: keywords)
    @content
  end
  
  def self.get_keywords(doc)
    doc.xpath("//meta[@name='keywords']/@content").text.split(", ")
  end
  
  def self.get_description(doc)
    doc.xpath("//meta[@name='description']/@content").text
  end
  
  def self.get_linktext(parse_page)
    parse_page.css('a').text
  end
  
  def self.get_link(parse_page)
    parse_page.css('a').length
  end
  
  def self.get_h3(parse_page)
    parse_page.css('h3').text
  end
  
  def self.get_h2(parse_page)
    parse_page.css('h2').text
  end
  
  def self.get_h1(parse_page)
    parse_page.css('h1').text
  end
  
  def self.get_p(parse_page)
    parse_page.css('p').text
  end
  
  def self.get_sum(parse_page)
    parse_page.text.sum
  end
  
  def self.get_source(parse_page)
    parse_page.text
  end
  
  def self.get_title(parse_page)
    parse_page.css('title').text
  end
  
end
