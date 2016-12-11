    module NokogiriParser
      
      def get_keywords(doc)
        doc.xpath("//meta[@name='keywords']/@content").text.split(", ")
      end
      
      def generate_hash(parse_page, str)
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
        h
      end
      
      def get_description(doc)
        doc.xpath("//meta[@name='description']/@content").text
      end
      
      def get_linktext(parse_page)
        parse_page.css('a').text
      end
      
      def get_link(parse_page)
        parse_page.css('a').length
      end
      
      def get_h3(parse_page)
        parse_page.css('h3').text
      end
      
      def get_h2(parse_page)
        parse_page.css('h2').text
      end
      
      def get_h1(parse_page)
        parse_page.css('h1').text
      end
      
      def get_p(parse_page)
        parse_page.css('p').text
      end
      
      def get_sum(parse_page)
        parse_page.text.sum
      end
      
      def get_source(parse_page)
        parse_page.text
      end
      
      def get_title(parse_page)
        parse_page.css('title').text
      end
    end