class Uacode

def pingApiForUaCode(m, str)
  darray = Array.new
  url = URI('https://api.spyonweb.com/v1/analytics/'+m+'?access_token=QpAlekatYxmO')
  doc1 = Nokogiri::HTML(open(url,:allow_redirections => :all))
  str1 =  doc1.text
  arr= str1.split(/"/)
  arr.each do |st|
      if (st.include? '.')
        if (st != str)
          darray.push(st)
        end
      end
  end
  return darray
end

def populate(darray, str, m, current_user)
    darray.each do |dom|
      unless (dom == str)
        if (dom.include? "www." )
          dom = Uacode.removeWWW(dom)
        else
          @domain1 = Domain.new(name: dom, uacode: m, author: current_user)
          @domain1.save
        end
      end
    end
end

def self.removeWWW(dom)
  dom.slice!("www.")
  dom
end

end