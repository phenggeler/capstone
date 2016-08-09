require 'rubygems'
require 'httparty'
require 'nokogiri'
require 'json'
require 'pry'
require 'csv'
require 'open-uri'
require 'open_uri_redirections'
require 'net/http'


#this is how we request the page we are going to scrape

 
 
      url = URI('https://api.spyonweb.com/v1/adsense/'+'pub-6085526195231822'+'?access_token=QpAlekatYxmO')
      parray = Array.new
        doc1 = Nokogiri::HTML(open(url,:allow_redirections => :all))
        str1 =  doc1.text
        arr= str1.split(/"/)
        arr.each do |st|
            if (st.include? '.')
 
                parray.push(st)
                puts st

            end

      end

#    parse_page = Nokogiri::HTML(page.body)
#          str1 =  doc1.text
#      arr= str1.split(/"/)
#    arr.each do |st|
#          if (st.include? '.')
#            if (st != str)
#              darray.push(st)
#            end
#          end
#      end
#    end
    

