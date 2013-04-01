# encoding: UTF-8
class SyncsController < ApplicationController

  def new
    client = OauthChina::Sina.new
    authorize_url = client.authorize_url
    Rails.cache.write(build_oauth_token_key(client.name, client.oauth_token), client.dump)
    redirect_to authorize_url
  end

  def callback
    client = OauthChina::Sina.load(Rails.cache.read(build_oauth_token_key(params[:type], params[:oauth_token])))
    client.authorize(:oauth_verifier => params[:oauth_verifier])

    results = client.dump

    if results[:access_token] && results[:access_token_secret]
      #\u5728\u8fd9\u91cc\u628aaccess token and access token secret\u5b58\u5230db
      #\u4e0b\u6b21\u4f7f\u7528\u7684\u65f6\u5019:
      #client = OauthChina::Sina.load(:access_token => "xx", :access_token_secret => "xxx")
      #client.add_status("\u540c\u6b65\u5230\u65b0\u6d6a\u5fae\u8584..")
      flash[:notice] = "\u6388\u6743\u6210\u529f\uff01"
    else
      flash[:notice] = "\u6388\u6743\u5931\u8d25!"
    end
    redirect_to root_path
  end

  private
  def build_oauth_token_key(name, oauth_token)
    [name, oauth_token].join("_")
  end
end
