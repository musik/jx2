#encoding: utf-8
class EntriesController < ApplicationController
  load_and_authorize_resource :except=>%w(hot)
  # GET /entries
  # GET /entries.json
  def index
    @title = "医药招商"
    @entries = Entry.recent.includes(:user).page(params[:page] || 1).per(30)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
    end
  end
  def hot
    @title = "热门招商信息"
    @entries = Entry.hot.includes(:user).page(params[:page] || 1).per(30)
    render :index
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])
    @entry.viewed
    breadcrumbs.add "医药招商",entries_url
    breadcrumbs.add nil
    #breadcrumbs.add @entry.title

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.json
  def new
    if current_user.contact_empty?
      redirect_to edit_profile_path(:from=>request.url),:notice=>"请先设置你的联系方式."
      return
    end
    if current_user.entries_full? 
      @full = true
      @noform = true
    else
      @entry = current_user.entries.new
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.json
  def create
    if current_user.entries_full?
      @full = true
      render action: "new"
      return
    end
    @entry = current_user.entries.new(params[:entry])

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render json: @entry, status: :created, location: @entry }
      else
        format.html { render action: "new" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.json
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to entries_url }
      format.json { head :no_content }
    end
  end
end
