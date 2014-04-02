# -*- encoding : utf-8 -*-
# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, page_header = nil, show_title = true)
    page_header ||= page_title
    if params[:page].present? and params[:page].to_i > 1
      page_title = "第#{params[:page]}页_#{page_title}"
      page_header += " / 第#{params[:page]}页"
    end
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
    content_for(:header) { h(page_header.to_s) }
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:footer) { javascript_include_tag(*args) }
  end
  def meta(name,content)
   eval  "@#{name} = '#{content}'"
    content_for(:head){
      "<meta name=\"#{name}\" content=\"#{content}\" />".html_safe
    }
  end
  def meta_desc str
    meta(:description,str)
  end
  def keywords *args
    meta(:keywords,args.join(","))
  end
  def is_home?
    request.url == root_url
  end
  def text_link_to text,url,options={}
    # "<tt class='text_link' longdesc='#{url}'>#{text}</tt>".html_safe

  end
  def js_external_link_to url
    "<script type='text/javascript'>
      document.write(\"<a href='#{url}' target='_blank' rel='nofollow'><img src='/images/go.gif' /></a>\")
    </script>".html_safe
  end
  def js_write text
    "<script type='text/javascript'>
      document.write('#{text}')
    </script>".html_safe
  end

  def pint i
    i.to_i > 1 ? " - 第#{i}页" : nil
  end

  def next_page
    params[:page].to_i+1
  end
  def prev_page
    params[:page].to_i == 2 ? nil : params[:page].to_i-1
  end
  def kami_array num
    num = 400 if num > 400
    Kaminari::PaginatableArray.new([],:limit=>40,:offset=>40*(params[:page].to_i - 1),:total_count=>num)
  end

    def nofollow_sub str
    str.gsub(/<(a href="[^"]+?")>/,'<\1 rel="">').gsub(/rel\=\"/,"rel=\"nofollow ").html_safe
  end
  def xpaginate scope, options = {}, &block
    paginator = Xpaginator.new self, options.reverse_merge(:current_page => scope.current_page, :total_pages => scope.total_pages, :per_page => scope.limit_value, :param_name => Kaminari.config.param_name, :remote => false, :theme=>"etao",:window=>100)
    paginator.to_s
  end
  def jsemail(str)
    ('<SCRIPT TYPE="text/javascript">
emailE=("'+str.reverse+'").split("").reverse().join("");
document.write(\'<A href="mailto:\' + emailE + \'">\' + emailE + \'</a>\')
 //-->
</script>

<NOSCRIPT>
    <em>Email address protected by JavaScript.<BR>
    Please enable JavaScript to contact me.</em>
</NOSCRIPT>').html_safe
  end
  def js_link_to str,href
    "<a href='javascript://' class='rl' data='#{href.to_rev}'>#{str}</a>".html_safe
  end
  def external_links txt
    return nil if txt.nil?
    txt.gsub(/<a href="(.+?)">/,'<a href="/redirect?url=\1" target="_blank" rel="nofollow">').html_safe
  end
  def is_ie6?
    request.env['HTTP_USER_AGENT'].present? and request.env['HTTP_USER_AGENT'].match(/MSIE 6\.0/).present?
  end
  def is_first?
    params[:page].nil?
  end
  def bdshare
    content_for:footer do
      render :file=>"share/bdshare_js"
    end
    render :file=>"share/bdshare"
  end
  def qq_link number,site='jxjw',text=nil
    '<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin='+number+'&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:'+number+':51" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>'.html_safe
  end
  def bdlike
    content_for:footer do
      render :file=>"share/bdlike_js"
    end
    '<div class="alert alert-like clearfix"><div class="bdlikebutton"></div></div>'.html_safe
  end
  def link_to_360kad name,title='康爱多网上药店'
      "<a href=\"http://cps.360kad.com//cpstransfer.php?unid=j1008&urlto=http://user.360kad.com/webapi/TrackZaoPai?url=http://search.360kad.com/?pageText=#{CGI.escape name}\" rel=\"nofollow\" target=\"_blank\" class=\"buylink btnx btnx-small\">#{title}</a>".html_safe
  end
  def link_to_111 name,title='1号药网'
      "<a href=\"http://search.111.com.cn/s2/c0-0/k#{CGI.escape name}/24/?tracker_u=2081374\" rel=\"nofollow\" target=\"_blank\" class=\"buylink btnx btnx-small\">#{title}</a>".html_safe
  end
end
