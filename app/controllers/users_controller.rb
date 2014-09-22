class UsersController < ApplicationController
  before_action :set_users, only: [:index]

  def index
    respond_to do |format|
      format.json
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.json
    end
  end

  private
  def set_users
    @users = User.all
    if params[:host]
      if params[:host] == "true"
        @users = @users.where(host: true)
      elsif params[:host] == "false"
        @users = @users.where(host: false)
      end
    end
  end
end
