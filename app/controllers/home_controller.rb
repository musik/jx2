# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def index
    @adm_baidu = false
    render :layout=>"application"
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
