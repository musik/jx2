# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def index
    @adm_baidu = false
    render :layout=>"application"
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
