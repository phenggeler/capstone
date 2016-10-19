class Pubcode

  def pingApiForPub(mp, str)
      parray = Array.new
      url = URI('https://api.spyonweb.com/v1/adsense/'+mp+'?access_token=QpAlekatYxmO')
      doc1 = Nokogiri::HTML(open(url,:allow_redirections => :all))
      str1 =  doc1.text
      arr= str1.split(/"/)
      arr.each do |st|
        if (st.include? '.')
          if (st != str)
            parray.push(st)
          end
        end
      end
      return parray
  end

  def populate(parray, str, mp, current_user)
      parray.each do |dom|
        unless (dom == str)
          if (dom.include? "www." )
            dom = Pubcode.removeWWW(dom)
          else
            @domain1 = Domain.new(name: dom, pubid: mp, author: current_user)
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