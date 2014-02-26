#encoding: utf-8
class JibingsController < ApplicationController
  load_and_authorize_resource :except=>%w()
  caches_action :index,:show,:expires_in => 1.day, :if => Proc.new { flash.count == 0 },:cache_path => Proc.new{ params}
  # GET /jibings
  # GET /jibings.json
  def index
    respond_to do |format|
      format.html {
        str = params.has_key?(:empty) ? "=" : ">"
        @jibings = Jibing.where("items_count #{str} 0").all
        breadcrumbs.add "常见疾病"
      }
      format.json { render json: Jibing.pluck(:name) }
      format.text { render text: Jibing.select("name,id").collect{|r|
        "http://www.jxjw.net/jibing/#{r.id}\t\t#{r.name}\t\t#{r.name}吃什么药\n"
      }.unshift("网址\t\t\t\t\t百科词条\t\t链接文字\n").join() 
      }
    end
  end

  # GET /jibings/1
  # GET /jibings/1.json
  def show
    @jibing = Jibing.find(params[:id])
    @items = @jibing.ji_items.page(params[:page] || 1).per(15)
    @jibings = Jibing.select("id,name").all.collect{|item|
      [item.id,item.name]
    }
    @jibings = Hash[@jibings]
    @names = @jibings.values.sort{|a,b|b.length <=> a.length}
    @names.delete(@jibing.name)
    @names = Regexp.new(@names.join('|'))
    breadcrumbs.add "常见疾病",jibings_path
    breadcrumbs.add "#{@jibing.name}"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @jibing }
    end
  end
  def suggest
    @jibing = Jibing.find(params[:id])
    @items = @jibing.suggest
    breadcrumbs.add "常见疾病",jibings_path
    breadcrumbs.add "#{@jibing.name}",jibing_path
    breadcrumbs.add "建议"
  end

  # GET /jibings/new
  # GET /jibings/new.json
  def new
    @jibing = Jibing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @jibing }
    end
  end

  # GET /jibings/1/edit
  def edit
    @jibing = Jibing.find(params[:id])
  end

  # POST /jibings
  # POST /jibings.json
  def create
    @jibing = Jibing.new(params[:jibing])

    respond_to do |format|
      if @jibing.save
        format.html { redirect_to @jibing, notice: 'Jibing was successfully created.' }
        format.js { @message = "#{@jibing.name} 创建成功。<a href='#{jibing_url(@jibing)}'>查看</a>".html_safe}
        format.json { render json: @jibing, status: :created, location: @jibing }
      else
        format.html { render action: "new" }
        format.js { @message = "#{@jibing.name} 创建失败。"}
        format.json { render json: @jibing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jibings/1
  # PUT /jibings/1.json
  def update
    @jibing = Jibing.find(params[:id])

    respond_to do |format|
      if @jibing.update_attributes(params[:jibing])
        format.html { redirect_to @jibing, notice: 'Jibing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @jibing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jibings/1
  # DELETE /jibings/1.json
  def destroy
    @jibing = Jibing.find(params[:id])
    @jibing.destroy

    respond_to do |format|
      format.html { redirect_to jibings_url }
      format.json { head :no_content }
    end
  end
end
