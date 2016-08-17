class Watcher < ApplicationRecord

    def self.makeObj(str, email)
    uri = URI('http://'+str)
    begin
      page = HTTParty.get(uri)
    rescue SocketError => e
      redirect_to new_domain_path, flash: {notice: "Cannot validate domain"} and return
    end
    doc = Nokogiri::HTML(open(uri,:allow_redirections => :all))
    #this is where we transfer our http response into Nokogiri object
    parse_page = Nokogiri::HTML(page)
    title = parse_page.css('title').text
    h1 = parse_page.css('h1').text
    h2 = parse_page.css('h2').text
    h3 = parse_page.css('h3').text
    p = parse_page.css('p').text
    link = parse_page.css("a").length
    linktext = parse_page.css("a").text
    description = doc.xpath('//meta[@name="Description"]/@content').text
    keywords = doc.xpath('//meta[@name="Keywords"]/@content').text
    @watcher = Watcher.new(domain: str, source: doc.text, email: email, title: title, p: p, h1: h1, h2: h2, h3: h3, link: link, linktext: linktext, description: description, keywords: keywords)
    end

    def current?(watcher)
        #pass emails
        @watcher = watcher
        @tmp = Watcher.makeObj(@watcher.domain, 'fake@fake.com')
        mssg = ''
        bigchange = false
        if (!@watcher.source.eql? @tmp.source)
            if (!@watcher.p.eql? @tmp.p)
              mssg = mssg + "P Text Has Changed"
              bigchange = true
            end
            if (!@watcher.title.eql? @tmp.title)
              mssg = mssg + "Title Has Changed"
              bigchange = true
            end
            if (!@watcher.link.eql? @tmp.link)
              mssg = mssg +"Number of links has changed"
              bigchange = true
            end
            if (!@watcher.linktext.eql? @tmp.linktext)
              mssg = mssg + "Some wording in links has changed"
              bigchange = true
            end
              UserMailer.site_change_email(@watcher, mssg).deliver
              @watcher = @tmp
            @tmp.destroy
        end
    end
end
