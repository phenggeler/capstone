class Pubcode


  def populate(parray, str, mp, current_user)
      parray.each do |dom|
        unless (dom == str)
          if (dom.include? "www." )
            dom = Pubcode.removeWWW(dom)
          else
            @domain1 = Domain.create(name: dom, pubid: mp, user: current_user)
          end
        end
      end
  end

  def self.removeWWW(dom)
    dom.slice!("www.")
    dom
  end
    
end