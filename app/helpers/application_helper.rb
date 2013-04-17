# -*- encoding : utf-8 -*-
module ApplicationHelper
  def adsense slot,name,args={}
    defaults={
      :width => 336,
      :height => 280,
      :slot => slot,
      :name => name
    }
    render :partial=>'layouts/adsense',:locals=>defaults.merge(args)
  end
  def ubaidu id,name
    <<-AD.html_safe
<script type="text/javascript">
/*#{name}*/
var cpro_id = "u#{id}";
</script>
<script src="http://cpro.baidustatic.com/cpro/ui/c.js" type="text/javascript"></script>
AD
  end
  def slotb
    #rand(2) > 0 ?
      #"<div class='slot' id='slotb'></div>".html_safe :
        adsense('1368561048','jx-before')
  end
  def slotf
    #rand(2) > 0 ?
      #"<div class='slot' id='slotf'></div>".html_safe :
        adsense('5659159841','jx-bottom')
  end
end
