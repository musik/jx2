# -*- encoding : utf-8 -*-

class ChengfensController < ApplicationController
  load_and_authorize_resource :except=>[:shouzi]
  # GET /chengfens
  # GET /chengfens.json
  def index
    @chengfens = Chengfen.page(params[:page] || 1).per(100)
    @title = "药物成分"
    breadcrumbs.add "药物成分",chengfens_url
    if params[:shouzi].present?
      @shouzi = params[:shouzi]
      @title = "#{@shouzi}开头的药物成分"
      @chengfens = @chengfens.where(:shouzi=>params[:shouzi]) 
      breadcrumbs.add "#{@shouzi}开头"
    end
    @groups = Chengfen.group(:shouzi).having('count_all > 5').
                count.sort{|a,b| b[1] <=> a[1]}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chengfens }
    end
  end
  def shouzi
    @groups = Chengfen.group(:shouzi).
                count.sort{|a,b| b[1] <=> a[1]}
    @title = "药物成分首字索引"
    breadcrumbs.add "药物成分",chengfens_url
    breadcrumbs.add @title
  end

  # GET /chengfens/1
  # GET /chengfens/1.json
  def show
    @chengfen = Chengfen.find(params[:id])
    @drugs = @chengfen.drugs.includes(:category)
    
    breadcrumbs.add @chengfen.name,nil

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chengfen }
    end
  end

  # GET /chengfens/new
  # GET /chengfens/new.json
  def new
    @chengfen = Chengfen.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chengfen }
    end
  end

  # GET /chengfens/1/edit
  def edit
    @chengfen = Chengfen.find(params[:id])
  end

  # POST /chengfens
  # POST /chengfens.json
  def create
    @chengfen = Chengfen.new(params[:chengfen])

    respond_to do |format|
      if @chengfen.save
        format.html { redirect_to @chengfen, notice: 'Chengfen was successfully created.' }
        format.json { render json: @chengfen, status: :created, location: @chengfen }
      else
        format.html { render action: "new" }
        format.json { render json: @chengfen.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chengfens/1
  # PUT /chengfens/1.json
  def update
    @chengfen = Chengfen.find(params[:id])

    respond_to do |format|
      if @chengfen.update_attributes(params[:chengfen])
        format.html { redirect_to @chengfen, notice: 'Chengfen was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chengfen.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chengfens/1
  # DELETE /chengfens/1.json
  def destroy
    @chengfen = Chengfen.find(params[:id])
    @chengfen.destroy

    respond_to do |format|
      format.html { redirect_to chengfens_url }
      format.json { head :no_content }
    end
  end
end
