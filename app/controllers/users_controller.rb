class UsersController < ApplicationController

  before_action :set_user, only: [:show]

  def index
    if params[:host] == true.to_s
      @users = User.hosts
    else
      @users = User.all
    end
  end

  def show
    @listings = @user.listings
    @reservations = @user.reservations
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
