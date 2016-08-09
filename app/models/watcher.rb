class Watcher < ApplicationRecord
    
    def current?(watcher)
        #pass emails
        @watcher = watcher
        uri = URI('http://'+@watcher.domain)
        begin
          page = HTTParty.get(uri)
        rescue SocketError => e
          #redirect_to new_domain_path, flash: {notice: "Cannot validate domain"} and return 
        end
        doc = Nokogiri::HTML(open(uri,:allow_redirections => :all))
        #this is where we transfer our http response into Nokogiri object
        parse_page = Nokogiri::HTML(page)
        if (!source.eql? doc.text)
            UserMailer.site_change_email(@watcher).deliver
        end
        source.eql? doc.text
    end
    
end
