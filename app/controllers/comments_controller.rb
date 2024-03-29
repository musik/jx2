#encoding: utf-8
class CommentsController < ApplicationController
  authorize_resource
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.recent.includes(:user).page(params[:page] || 1).per(10)
    breadcrumbs.add :comments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment ||= Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @obj = Comment.find_commentable(params[:atype],params[:aid].to_i)
    params[:comment][:author_ip] = request.remote_ip
    params[:comment][:user_id] = user_signed_in? ? current_user.id : 0
    #logger.info params
    @comment = Comment.build_from(@obj,params[:comment])
    #logger.info @comment.spam?

    respond_to do |format|
      if @comment.save
        format.html { redirect_to params[:aurl], notice: '留言成功' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        logger.debug @comment.errors.inspect
        format.html { 
          @name = @obj.respond_to?(:wenhao) ? @obj.wenhao : @obj.name
          if @obj.is_a?(Yaopin)
            @link = "/pihao/#{CGI.escape @obj.wenhao}"
          end
          breadcrumbs.add @name,@link
          @hide_bread = false
          render action: "new" 
          #redirect_to params[:aurl]
        }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end
end
