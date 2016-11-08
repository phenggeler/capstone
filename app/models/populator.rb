class Populator

  def populate(darray, str, m, mp, current_user)
      darray.each do |dom|
        unless (dom == str)
          if (dom.include? "www." )
            dom = Uacode.removeWWW(dom)
          else
            @domain1 = Domain.create(name: dom, uacode: m, pubid: mp, user: current_user)
          end
        end
      end
  end

  def self.removeWWW(dom)
    dom.slice!("www.")
    dom
  end

end