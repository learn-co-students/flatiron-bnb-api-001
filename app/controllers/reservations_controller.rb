class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :update, :destroy]

  def index
    if status = params[:status]
      @reservations = Reservation.where(status: status)
    else
      @reservations = Reservation.all
    end
    respond_to do |format|
      format.json
    end
  end

  def show
    respond_to do |format|
      format.json
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      render json: @reservation, status: 201, location: @reservation
    else
      render json: @reservation.errors, status: 422
    end
  end

  def update
    if @reservation.update(reservation_params)
      render json: @reservation, status: 200
    else
      render json: @reservation.errors, status: 422
    end
  end

  def destroy
    @reservation.destroy
    head 204
  end

  private
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:checkin, :checkout, :listing_id, :guest_id)
  end

end
