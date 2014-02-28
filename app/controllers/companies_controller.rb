#encoding: utf-8
class CompaniesController < ApplicationController
  load_and_authorize_resource :only=>%w(new edit update create destroy)
  before_filter :_init
  before_filter :_bc,only: %w(all province show)
  def _init
    @title_suffix = ""
    @hide_subnav = true
    @hide_foot = true
  end
  def _bc
    breadcrumbs.add "制药企业大全",root_url(subdomain: 'c')
  end
  def index
    @companies = Company.order('yaopins_count desc').includes(:province,:city).limit(50)
    breadcrumbs.add "制药企业大全",nil
  end
  def all
    @companies = Company.includes(:province,:city).page(params[:page])
  end
  def province
    @province = Province.where(pinyin: params[:id]).first
    @companies = Company.where(province_id: @province).includes(:city).page(params[:page])
    breadcrumbs.add @province.short_name,(params[:page].nil? ? nil : province_url(@province))
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find(params[:id])
    @pihao = @company.yaopins.page(params[:page])
    breadcrumbs.add @company.short,(params[:page].nil? ? nil : company_url(@company))

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
end
