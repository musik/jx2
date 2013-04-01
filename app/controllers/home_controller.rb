# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def index
    @adm_baidu = false
    render :layout=>"application"
  end
end
