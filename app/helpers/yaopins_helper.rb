# -*- encoding : utf-8 -*-
module YaopinsHelper
  def yaopin_column k,v
    if respond_to? "yaopin_#{k}"
      send "yaopin_#{k}",v
    else
      v
    end 
  end
  def yaopin_jixing v
    link_to v,jixing_url(v)
  end
  def yaopin_leibie v
    link_to v,leibie_url(v)
  end
end
