class ApiPing

  def pingApiForCode(m, str, targetcode)
    darray = Array.new
    url = URI('https://api.spyonweb.com/v1/'+targetcode+'/'+m+'?access_token=QpAlekatYxmO')
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

end