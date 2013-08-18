# -*- encoding : utf-8 -*-
#encoding: utf-8
class DrugsController < ApplicationController
  load_and_authorize_resource :except=>[:category,:pihao,:shuomingshu,:track,:shouzi]

  before_filter :this_init
  def this_init
    breadcrumbs.add :drugs,drugs_url,:rel=>"nofollow"
  end
  # GET /drugs
  # GET /drugs.json
  def index
    @drugs = Drug.inlist.includes(:category).page(params[:page] || 1).per(params[:per] || 200)
    if params[:abbr]
      @abbr = params[:abbr]
      @drugs = @drugs.where(:abbr=>params[:abbr])
      @title = "#{@abbr}开头的药品"
      breadcrumbs.add "#{@abbr}开头"
    elsif params[:shouzi].present?
      @shouzi = params[:shouzi]
      @title = "#{@shouzi}字开头的药品"
      @drugs = @drugs.where(:shouzi=>params[:shouzi]) 
      breadcrumbs.add "#{@shouzi}字开头"
    else
      @categories = Category.roots
    end
    breadcrumbs.add "第#{params[:page]}页",nil if params[:page]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @drugs }
      format.text { render text: Drug.yaopin_order.page(params[:page] || 1).per(params[:per] || 100).pluck(:name).join("\r\n") }
    end
  end
  def shouzi
    @groups = Drug.group(:shouzi).
                count.sort#{|a,b| b[1] <=> a[1]}
    @title = "药品首字索引"
    breadcrumbs.add "药品",drugs_url
    breadcrumbs.add @title
  end
  def track
    @drug = Drug.where(:id=>params[:id]).first
    request.env["HTTP_REFERER"] = CGI.unescape(params["referer"])
    logger.debug request.env["HTTP_REFERER"]
    track_page_view(@drug)
    render :nothing=>true
  end
  def category
    @category = Category.find(params[:category_id])
    if @category.leaf?
      @drugs = Drug.inlist.order("id asc").where(:category_id=>@category.id)
      @categories = @category.self_and_siblings
      @hide_category = true
    else
      @descendants_ids = @category.descendants.leaves.pluck(:id)
      @drugs = Drug.includes(:category).where(:category_id=>@descendants_ids)

      @categories = @category.children
    end

    set_category_crumbs @category

    @drugs = @drugs.page(params[:page] || 1).per(100)

    @title = @category.name
    render :index
  end
  def manage
    @drugs = Drug.inlist.page(params[:page] || 1).per(100)

  end
  def set_category_crumbs category,is_self = true
    unless category.root?
      category.ancestors.each do |c|
        breadcrumbs.add c.name,category_url(c)
      end
    end
    breadcrumbs.add category.name,is_self ? nil : category_url(category)
  end

  # GET /drugs/1
  # GET /drugs/1.json
  def show
    if @drug.nil?
      render_404
      return
    end
    @q = @drug.name
    if @drug.category.present?
      set_category_crumbs @drug.category,false
    end

    @chengfens = @drug.chengfens.all
    @yaopins = @drug.yaopins.newest.limit(10).all
    breadcrumbs.add @drug.name,nil

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @drug }
    end
  end
  def shuomingshu
    #@drug = Drug.find(params[:id].sub(/说明书/,''))
    @drug = Drug.find(params[:id])
    breadcrumbs.add @drug.name,"/yaopin/#{CGI.escape @drug.name}/pihao"
    @title = "#{@drug.name}说明书"
    breadcrumbs.add @title,nil

  end
  def pihao
    @drug = Drug.find(params[:id])
    render_404 and return if @drug.nil?
    respond_to do |format|
      format.html {
        if @drug.category.present?
          set_category_crumbs @drug.category,false
        end
        breadcrumbs.add @drug.name,nil
        @pihao = @drug.yaopins.newest.page(params[:page] || 1).per(100)
      }
      format.pdf
    end
  end

  # GET /drugs/new
  # GET /drugs/new.json
  def new
    @drug = Drug.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @drug }
    end
  end

  # GET /drugs/1/edit
  def edit
    @drug = Drug.find(params[:id])
  end

  # POST /drugs
  # POST /drugs.json
  def create
    @drug = Drug.new(params[:drug])

    respond_to do |format|
      if @drug.save
        format.html { redirect_to @drug, notice: 'Drug was successfully created.' }
        format.json { render json: @drug, status: :created, location: @drug }
      else
        format.html { render action: "new" }
        format.json { render json: @drug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /drugs/1
  # PUT /drugs/1.json
  def update
    @drug = Drug.find(params[:id])

    respond_to do |format|
      if @drug.update_attributes(params[:drug])
        format.html { redirect_to @drug, notice: 'Drug was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @drug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drugs/1
  # DELETE /drugs/1.json
  def destroy
    @drug = Drug.find(params[:id])
    @drug.destroy

    respond_to do |format|
      format.html { redirect_to drugs_url }
      format.json { head :no_content }
    end
  end
end
