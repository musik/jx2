# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to root_path, :alert => exception.message
    else
      session["user_return_to"] = request.url
      redirect_to new_user_session_url , :alert => I18n.t("unauthorized.sign_in")
    end
  end
  before_filter :init_breadcrumbs
  #after_filter :store_location
  #def store_location
    #session["user_return_to"] = request.url
  #end
  def init_breadcrumbs
    return if request.url.match "admin"
    session["init"] = true
    breadcrumbs.add :home,root_url,:rel=>"nofollow"
    if %w(confirmations sessions passwords registrations links entries users).include? controller_name 
      @hide_ad_before = true
      @hide_slotf = true
      @hide_adside = true
      @hide_bread = true
      @col1 = true 
    end
    #logger.debug session
    @body_class = "c-#{controller_name} a-#{action_name}"
    # vars
    # @adm_baidu
    #@adm_baidu = true
  end
  def after_sign_in_path_for(resource)
    url = after_path_for(resource)
    resource.contact_empty? ? edit_profile_path(:from=>url) : url
  end  
  def after_path_for(resource)
    stored_location_for(resource) || root_path
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
