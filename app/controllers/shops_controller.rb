#encoding: utf-8
class ShopsController < ApplicationController
  load_and_authorize_resource :except=>%w(redirect)
  before_filter :_noad

  def _noad
    @hide_subnav = true
    @js = "shops"
    @ng_app = "Shops"
    @title_suffix = "_网上药店排名"
    breadcrumbs.add "网上药店",action_name == "index" ? nil : shops_url
    super
  end
  # GET /shops
  # GET /shops.json
  def index
    @shops = Shop.order('isnull(alexa) asc,alexa asc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { 
        q = "%#{params[:q]}%"
        @shops = @shops.
          where("name like ? or domain like ? or cert like ?",q,q,q) if params[:q].present?
        render json: @shops 
      }
    end
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
    @shop = Shop.find(params[:id])
    breadcrumbs.add @shop.name,nil

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop }
    end
  end
  def redirect
    @shop = Shop.find(params[:id])
    redirect_to @shop.website,status: 301
  end

  # GET /shops/new
  # GET /shops/new.json
  def new
    @shop = Shop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop }
    end
  end

  # GET /shops/1/edit
  def edit
    @shop = Shop.find(params[:id])
  end

  # POST /shops
  # POST /shops.json
  def create
    @shop = Shop.new(params[:shop])

    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
        format.json { render json: @shop, status: :created, location: @shop }
      else
        format.html { render action: "new" }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shops/1
  # PUT /shops/1.json
  def update
    @shop = Shop.find(params[:id])

    respond_to do |format|
      if @shop.update_attributes(params[:shop])
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy

    respond_to do |format|
      format.html { redirect_to shops_url }
      format.json { head :no_content }
    end
  end
end
