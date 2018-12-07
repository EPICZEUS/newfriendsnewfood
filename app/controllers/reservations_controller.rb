class ReservationsController < ApplicationController
  before_action :find_reservation, only: [:show, :destroy]

  def show
    #find_reservation
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      @reservation.group.users.each do |user|
        user.group_searches.find { |e| e.restaurant == @reservation.restaurant }.destroy
      end
      redirect_to [current_user, @reservation.group]
    else
      flash[:errors] = @reservation.errors.full_messages
      redirect_to [current_user, params[:group_id]]
    end
  end

  def destroy
    @reservation.group.users.each { |e| e.group_searches << GroupSearch.create(user_id: e.id, restaurant_id: @reservation.restaurant.id) }
    @reservation.destroy
    redirect_to user_group_path(current_user, params[:group_id])
  end

  private

  def find_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    time_vals = params[:date]
    params[:reservation][:time] = Time.new(time_vals[:year], time_vals[:month], time_vals[:day], time_vals[:hour], time_vals[:minute])
    params.require(:reservation).permit(:time, :restaurant_id, :group_id)
  end
end
