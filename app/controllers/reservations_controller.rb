class ReservationsController < ApplicationController
  before_action :find_reservation, only: [:show, :edit, :update, :destroy]

  def index
    @reservations = Reservation.all
  end

  def show
    #find_reservation
  end

  def new
    @reservation = Reservation.new
    @groups = Group.all
    @restaurants = Restaurant.all
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      @reservation.group.users.each do |user|
        user.group_searches.find { |e| e.restaurant == @reservation.restaurant }.destroy
      end
      redirect_to [@current_user, @reservation.group, @reservation]
    else
      flash[:errors] = @reservation.errors.full_messages
      redirect_to user_group_path(params[:user_id], params[:group_id])
    end
  end

  def edit
    #find_reservation
    @groups = Group.all
    @restaurants = Restaurant.all
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
    # byebug
    # time_vals = params[:date].values
    params[:reservation][:time] = Time.new(*params[:date].values)
    params.require(:reservation).permit(:time, :restaurant_id, :group_id)
  end
end
