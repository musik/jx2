
class ToolsController < ApplicationController
  def adsense_preview
    @client = 'ca-digitalinspiration'
    @client = 'ca-jxjwnetjxjwnetjxjw'
    render :layout=>false if params[:inframe].present?
  end
  def adsense
    @url = params[:url] || 'http://www.jxjw.net'
    @url = 'http://www.jxjw.net' if @url == 'http://'
    @gl = params[:gl] || 'CN'
    @hl = params[:hl] || 'zh_CN'
  end
  def _fetch_title url
    res = Typhoeus::Request.get(url)
    doc = Nokogiri::HTML(res.body)
    doc.title
  end
end

