class ReservationsController < ApplicationController
  before_action :find_reservation, only: [:show, :edit, :create, :destroy]

  def index
    @reservations = Reservation.all
  end

  def show
    #find_reservation
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new
    if @reservation.save
      redirect_to reservation_path(@reservation)
    else
      flash[:errors] = @reservation.errors.full_messages
      redirect_to new_reservation_path
    end
  end

  def edit
    #find_reservation
  end

  def update
    #find_reservation
    if @reservation.update
      redirect_to reservation_path(@reservation)
    else
      flash[:errors] = @reservation.errors.full_messages
      redirect_to edit_reservation_path
    end
  end

  def destroy
    #find_reservation
    reservation.destroy
  end

  private

  def find_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:time, :restaurant_id, :group_id)
  end
end
