class ReservationsController < ApplicationController

  include ActiveModel::Validations

  validates_presence_of :checkin, :checkout, :guest_id, :listing_id

def index
  @reservations = Reservation.all
end

def show
  @reservation = Reservation.find(params[:id])
end

def create
    @reservation = Reservation.new(reservation_params)

    if !@reservation.save
      redirect_to '/reservations/index', status: 422
    else
      redirect_to @reservation, status: 201
    end
end

def update
  @reservation = Reservation.find(params[:id])
  @reservation.update(reservation_params)

  if @reservation.save
    redirect_to @reservation, status: 200
  else
    redirect_to @reservation, status: 422
  end
end

def destroy
  Reservation.find(params[:id]).delete
  redirect_to 'reservations', status: 204
end

private

    def reservation_params
      params.require(:reservation).permit(:checkin, :checkout, :guest_id, :listing_id)
    end

end
