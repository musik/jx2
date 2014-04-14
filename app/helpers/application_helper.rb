# -*- encoding : utf-8 -*-
module ApplicationHelper
  def is_zhaoshang?
    controller_name == "entries"
  end
  def nav_classes
    classes = {controller_name.to_sym => 'active'}
  end
  def zhaoshang_classes
    classes = {action_name.to_sym => 'active'}
  end
  def adsense slot,name,args={}
    defaults={
      :width => 336,
      :height => 280,
      :slot => slot,
      :name => name,
      :cls => "slot"
    }
    render :partial=>'layouts/adsense',:locals=>defaults.merge(args)
  end
  def ubaidu id,name,t=''
    #return if Rails.env.development?
    <<-AD.html_safe
<script type="text/javascript">
/*#{name}*/
var cpro_id = "u#{id}";
</script>
<script src="http://cpro.baidustatic.com/cpro/ui/c#{t}.js" type="text/javascript"></script>
AD
  end
  def usogou id,width=200,height=200
    <<-Ad.html_safe
    <script type="text/javascript">
var sogou_ad_id=#{id};
var sogou_ad_height=#{height};
var sogou_ad_width=#{width};
</script>
<script language='JavaScript' type='text/javascript' src='http://images.sohu.com/cs/jsfile/js/c.js'></script>
    Ad
  end
  def bdshare
    content_for :footer do
      <<-Bd.html_safe
  <!-- Baidu javascript BEGIN -->
  <script type="text/javascript" id="bdshare_js" data="type=button&amp;uid=490604" ></script>
  <script type="text/javascript" id="bdshell_js"></script>
  <script type="text/javascript">
  document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000);
  </script>
  <!-- Baidu javascript END -->    
      Bd
    end
    <<-Bd.html_safe
<!-- Baidu Button BEGIN -->
<div id="bdshare" class="bdshare_b" style="line-height: 12px;">
<img src="http://bdimg.share.baidu.com/static/images/type-button-2.jpg?cdnversion=20120831" />
<a class="shareCount"></a>
</div>
<!-- Baidu Button END -->    
    Bd
  end
  def slotb
    #rand(2) > 0 ?
      #"<div class='slot' id='slotb'></div>".html_safe :
        #adsense('1368561048','jx-before')
      ("<div class='slotb'>" + ubaidu(1356188,'jx-before') + "</div>").html_safe
  end
  def slotf
    #rand(2) > 0 ?
      #"<div class='slot' id='slotf'></div>".html_safe :
        #adsense('5659159841','jx-bottom')
  end

  def search_options
    {pihao: "批号",yaopin: "药品"}.invert
  end
end
