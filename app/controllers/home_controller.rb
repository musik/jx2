# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  #caches_action :index,:expires_in => 1.day, :if => Proc.new { flash.count == 0 }
  def index
    #_parse_referer
    @adm_baidu = false
    render 'index',:layout=>"application"
  end
  def mmseg
    @results = Drug.mmseg
  end
  def flush
    expire_action :action=>:index
    redirect_to root_url
  end
  def sitemap
    @files = Dir.entries("#{Rails.root}/public/sitemap")
    @files -= ['.','..']
    @files.sort!
    logger.debug @files
    respond_to do |format|
      format.xml
      format.text {
        render text: @files.collect{|f| root_url + 'sitemap/' + f}.join("\r\n")
      }
    end
  end
  def souyao
    breadcrumbs.add "搜索网上药店"
    @hide_ad_before = @hide_slotf = @col5 = true
  end
  def stats
    @hide_ad_before = @hide_slotf = @col1 = true
    @data = {
      items_count: Item.count,
      items_grouped: Item.group(:scope).count,
      drugs_count: Drug.count,
      drugs_yaopins_empty_count: Drug.where("yaopins_count = 0").count,
      drugs_items_present_count: Drug.where("items_count > 0").count,
      drugs_shuoming_present_count: Drug.where("shuoming is not null").count,
      drugs_description_present_count: Drug.where("description is not null").count,
      yaopins_count: Yaopin.count,
      jibings_count: Jibing.count,
      jibings_items_present_count: Jibing.where("items_count > 0").count,
    }
    @items = Item.group(:scope).includes(:yaopin).all
  end
  def archive
    @yaopins = Yaopin.search(nil,
        :group_by => 'pizhunri',
        :group_function => :month,
        :order => 'pizhunri ASC',
        :per_page=>1000)
    @groups = []
    @yaopins.each_with_group_and_count do |t,group,count|
      @groups << [group,count]
    end
    @groups.sort!{|a,b| a[0]<=> b[0]}
    breadcrumbs.add "存档",nil
  end
  def date
    if params[:date].length == 8
      @range = 'day'
      @datestr = params[:date]
      @format = "%Y-%m-%d"
      @date = Date.parse @datestr
      @next = @date + 1.day
    elsif params[:date].length == 6
      @range = 'month'
      @datestr = params[:date] + "01"
      @format = "%Y-%m"
      @date = Date.parse @datestr
      @next = @date + 1.month
    end
    @yaopins = Yaopin.search(
      :with => {:pizhunri => @date..@next},
      :page => params[:page],
      :per_page => 100
    )
    breadcrumbs.add "存档",'/archive'
    breadcrumbs.add @date.strftime(@format),nil
  end
  def test
    render :layout=>"application"
  end
  def goto
    if params[:class_name] == 'Yaopin'
      @yaopin = Yaopin.find params[:id].to_i
      redirect_to "/pihao/#{@yaopin.to_param}"
    end

  end
  def _parse_referer
    @referer = request.referer
    #@referer = 'http://www.baidu.com/s?wd=%E5%9B%BD%E8%8D%AF%E5%87%86%E5%AD%97%E6%9F%A5%E8%AF%A2&rsv_bp=0&ch=33&tn=ppsbaibu_oem_dg&bar=&rsv_spt=3&ie=utf-8&rsv_sug3=2&rsv_sug=0&rsv_sug1=2&rsv_sug4=1248&oq=%E5%9B%BD%E8%8D%AF&rsp=0&f=3&rsv_sug2=1&rsv_sug5=0&inputT=13963' if Rails.env.development?
    #@referer = 'http://www.baidu.com/s?tn=56060048_4_pg&ch=1&ie=utf-8&bs=%E4%BA%BA%E5%8F%82%E5%81%A5%E8%84%BE%E7%89%87%200.25g*48%E7%B2%92%E7%9A%84%E5%9B%BD%E8%8D%AF%E5%87%86%E5%AD%97&f=3&rsv_bp=1&wd=%E5%9B%BD%E8%8D%AF%E5%87%86%E5%AD%97%E6%9F%A5%E8%AF%A2%E7%BD%91&rsv_sug3=8&rsv_sug4=5688&rsv_sug=0&rsv_sug1=4&oq=%E5%9B%BD%E8%8D%AF%E5%87%86%E5%AD%97&rsp=7&rsv_sug2=1&rsv_sug5=0&inputT=18781'
    #@referer = 'http://www.soso.com/q?unc=i400044&cid=union.s.wh&ie=utf-8&w=国药准字&searchRadio=on'
    @ref_keywords = Hash[@referer.scan(/[\?\&](bs|wd|q|pq|w)\=([^\&]+)/)].values
    @ref_keywords.each do |v|
      @ref_keywords.delete(v) if CGI.unescape(v) == "国药准字"
      @ref_keywords.delete(v) if CGI.unescape(v).match("查询")
    end
  end
end
