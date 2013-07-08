# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def index
    @adm_baidu = false
    render :layout=>"application"
  end
  def sitemap
    @files = Dir.entries("#{Rails.root}/public/sitemap")
    @files -= ['.','..']
    logger.debug @files
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
end
