# -*- encoding : utf-8 -*-
class YaopinsController < ApplicationController
  caches_action :index,:search,:expires_in => 1.day, :if => Proc.new { flash.count == 0 },
    :cache_path => Proc.new{params}

  load_and_authorize_resource :except=>%w(name jixing leibie auto_complete search track map)
  before_filter :init_breadcrumbs#,:except=>[:show]


  # GET /yaopins
  # GET /yaopins.json
  def index
    @yaopins = Yaopin.order("id desc").page(params[:page] || 1).per(params[:per] || 100)
    if params[:name].present?
      @yaopins = @yaopins.where(:name=>params[:name])
    end

  end
  def map
    respond_to do |format|
      format.html {
        @yaopins = Yaopin.page(params[:page] || 1).per(params[:per] || 500).select(%w(id wenhao))
        breadcrumbs.add "第#{params[:page]}页",nil if params[:page]
      }
      format.xml {
        @yaopins = Yaopin.page(params[:page] || 1).per(params[:per] || 5000).select(%w(id wenhao))
        
      }
    end
  end
  def track
    @yaopin = Yaopin.where(:id=>params[:id]).first
    request.env["HTTP_REFERER"] = CGI.unescape(params["referer"])
    track_page_view(@yaopin)
    render :nothing=>true
  end
  def search
    @q = params[:q]
    #@yaopins = Yaopin.search @q,:per_page=>20, :page=>params[:page] || 1
    if @q.match(/[a-z0-9]/i)
      @yaopins = Yaopin.where(["name like ? or wenhao like ?","%#{params[:q]}%","%#{params[:q]}%"]).page(params[:page] || 1).per(20)
    else
      @yaopins = Yaopin.search @q,
          :per_page=>20, :page=>params[:page] || 1
    end
    @title="搜索\"#{@q}\""
    @hide_leibie = true
    breadcrumbs.add "搜索\"#{@q}\""
  end
  def auto_complete
    @term = params[:term]
    if @term.match(/[a-z0-9]/i)
      @topics = Yaopin.select([:name,:wenhao]).where("wenhao like ?","%#{@term}%").limit(10).all
    else
      @topics = Yaopin.search @term,:per_page=>10
    end
    if @topics.present?
      @results = @topics.collect do |t|
        #{:label=>"#{t.wenhao}<small>#{t.name}</small>",:value=>show_yao_url(t.name)}
        {:label=>"#{t.wenhao}/#{t.name}",:value=>yaopin_url(t)}
      end
      @results << {:label=>"共#{@topics.total_entries}项结果",:value=>search_yaopins_url(:q=>@term)} if @topics.respond_to? :total_entries
    else
      @results = [{:label=>t('auto_complete.not_found'),:value=>0}]
    end
    render :json => @results.to_json
  end
  def auto_complete_ar
    @term = params[:term]
    if @term =~ /[国药准字A-Z0-9a-z]/
      @topics = Yaopin.select([:name,:wenhao]).where(["name like ? or wenhao like ?","%#{params[:term]}%","%#{params[:term]}%"]).limit(10).collect{|t|
        {:label=>[t.wenhao,t.name].join('/'),:value=>yaopin_url(t)}
      }
      else
      @topics = Drug.select([:name,:en]).where(["name like ?","%#{params[:term]}%"]).limit(10).collect{|t|
        {:label=>[t.name,t.en].join('/'),:value=>show_yao_url(t.name)}
      }
    end

    if @topics.empty?
        render :json => [{:label=>t('auto_complete.not_found'),:value=>0}].to_json
      else
        render :json => @topics.to_json
    end

  end
  def name
    @yaopins = Yaopin.where(:name=>params[:name]).page(params[:page] || 1).per(100)
    @hide_yaoming = true
    @title = params[:name]

    breadcrumbs.add :name,nil
    breadcrumbs.add @title,nil
    render :index
  end
  def jixing
    @yaopins = Yaopin.newest.where(:jixing=>params[:jixing]).page(params[:page] || 1).per(100)
    @title = params[:jixing]

    breadcrumbs.add :jixing,nil
    breadcrumbs.add @title,nil
    render :index
  end
  def leibie
    @yaopins = Yaopin.newest.where(:leibie=>params[:leibie]).page(params[:page] || 1).per(100)
    @leibie = params[:leibie]
    @title = params[:leibie]

    breadcrumbs.add :leibie,nil
    breadcrumbs.add @title,nil
    render :index
  end
  def manage
    @yaopins = Yaopin.page(params[:page] || 1).per(100)
  end

  # GET /yaopins/1
  # GET /yaopins/1.json
  def show
    @yaopin = Yaopin.find(params[:id])
    #logger.debug @yaopin
    @q = @yaopin.wenhao

    @drug = @yaopin.drug
    @yaopins = @drug.yaopins.newest.limit(10).all if @drug.yaopins_count > 1

    breadcrumbs.add @drug.name,"/yaopin/#{@drug.to_param}/pihao" if @drug.present?
    breadcrumbs.add @yaopin.wenhao,nil
    session["user_return_to"] = request.url
    #render [0,1].sample > 0 ? "show" : "show1"
  end

  # GET /yaopins/new
  # GET /yaopins/new.json
  def new
    @yaopin = Yaopin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @yaopin }
    end
  end

  # GET /yaopins/1/edit
  def edit
    @yaopin = Yaopin.find(params[:id])
  end

  # POST /yaopins
  # POST /yaopins.json
  def create
    @yaopin = Yaopin.new(params[:yaopin])

    respond_to do |format|
      if @yaopin.save
        format.html { redirect_to @yaopin, notice: 'Yaopin was successfully created.' }
        format.json { render json: @yaopin, status: :created, location: @yaopin }
      else
        format.html { render action: "new" }
        format.json { render json: @yaopin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /yaopins/1
  # PUT /yaopins/1.json
  def update
    @yaopin = Yaopin.find(params[:id])

    respond_to do |format|
      if @yaopin.update_attributes(params[:yaopin])
        format.html { redirect_to @yaopin, notice: 'Yaopin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @yaopin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /yaopins/1
  # DELETE /yaopins/1.json
  def destroy
    @yaopin = Yaopin.find(params[:id])
    @yaopin.destroy

    respond_to do |format|
      format.html { redirect_to yaopins_url }
      format.json { head :no_content }
    end
  end
  private
  def init_breadcrumbs
    super
    breadcrumbs.add :yaopin,yaopins_url unless action_name == 'show'
  end

end
