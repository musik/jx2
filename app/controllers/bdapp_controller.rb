# -*- encoding : utf-8 -*-
class BdappController < ApplicationController
  include BdappHelper
  def index
    
  end
  def search
    @q = params[:q]
    @yaopins = Yaopin.where(["name like ? or wenhao like ?","%#{params[:q]}%","%#{params[:q]}%"]).page(params[:page] || 1).per(6)
    @title="搜索\"#{@q}\""
  end
  def pihao
    @yaopin = Yaopin.where(:id=>params[:id]).first
    @q = @yaopin.wenhao
  end
  def drug
    @drug = Drug.where(:id=>params[:id]).first
    @q = @drug.name
    @yaopins = @drug.yaopins.page(params[:page] || 1).per(6)
  end
  def auto_complete
    @term = params[:term].strip
    if @term =~ /[国药准字A-Z0-9a-z]/
      @topics = Yaopin.select([:name,:wenhao,:id]).where(["name like ? or wenhao like ?","%#{@term}%","%#{@term}%"]).limit(10).collect{|t|
        {:label=>[t.wenhao,t.name].join('/'),:value=>bdapp_pihao_link(t)}
      }
      else
      @topics = Drug.select([:name,:en,:id]).where(["name like ?","%#{@term}%"]).limit(10).collect{|t|
        {:label=>[t.name,t.en].join('/'),:value=>bdapp_drug_link(t)} }
    end

    if @topics.empty?
        render :json => [{:label=>t('auto_complete.not_found'),:value=>0}].to_json
      else
        render :json => @topics.to_json
    end

  end

end
