# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end
  def edit_profile
    @user = current_user
    #logger.debug @user
  end
  def update_profile
    @user = current_user
    if @user.update_without_password(params[:user])
      redirect_to (params[:from].present? ? params[:from] : after_path_for(@user)),:notice=>"资料已更新"
    else
      render :edit_profile
    end

  end


  def show
    @user = User.find(params[:id])
  end

end
