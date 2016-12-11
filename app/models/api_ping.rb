require 'openssl'

class ApiPing

  def ping_api_for_code(m, str, targetcode)
    darray = Array.new
    url = URI('https://api.spyonweb.com/v1/'+targetcode+'/'+m+'?access_token=QpAlekatYxmO')
    doc1 = Nokogiri::HTML(open(url,:allow_redirections => :all, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
    str1 =  doc1.text
    darray = str1.split(/"/).keep_if { |st| (st.include? '.') && (st != str) }
    darray
  end

end