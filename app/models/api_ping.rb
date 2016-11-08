class ApiPing

  def pingApiForCode(m, str, targetcode)
    darray = Array.new
    url = URI('https://api.spyonweb.com/v1/'+targetcode+'/'+m+'?access_token=QpAlekatYxmO')
    doc1 = Nokogiri::HTML(open(url,:allow_redirections => :all))
    str1 =  doc1.text
    darray = str1.split(/"/).keep_if { |st| (st.include? '.') && (st != str) }
    darray
  end

end