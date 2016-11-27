class Populator

  def populate(darray, m, mp, builder)
      darray.each do |dom|
        unless (dom == builder[0])
          if (dom.include? "www." )
            dom = Uacode.remove_www(dom)
          else
            @domain1 = Domain.create(name: dom, uacode: m, pubid: mp, user: builder[1])
          end
        end
      end
  end

  def self.remove_www(dom)
    dom.slice!("www.")
    dom
  end

end