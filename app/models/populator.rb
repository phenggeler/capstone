class Populator

  def populate(darray, m, mp, builder)
      darray.each do |dom|
        unless (dom == builder[0])
          if (dom.include? "www." )
            dom = Uacode.removeWWW(dom)
          else
            @domain1 = Domain.create(name: dom, uacode: m, pubid: mp, user: builder[1])
          end
        end
      end
  end

  def self.removeWWW(dom)
    dom.slice!("www.")
    dom
  end

end