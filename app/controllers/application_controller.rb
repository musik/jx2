# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  before_filter :init_breadcrumbs
  def init_breadcrumbs
    return if request.url.match "admin"
    breadcrumbs.add :home,root_url,:rel=>"nofollow"
    if %w(confirmations sessions passwords registrations links entries users).include? controller_name 
      @hide_ad_before = true
      @hide_slotf = true
      @hide_adside = true
    end
    # vars
    # @adm_baidu
    #@adm_baidu = true
  end
  protected
  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end
    l2 = ActiveSupport::BufferedLogger.new("#{Rails.root}/log/404.log")
    l2.info [Time.now,request.url,request.remote_ip].join(' - ')

    respond_to do |format|
      format.html { render :file => "error/404", :status => :not_found}#,:layout=>false }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end
end
