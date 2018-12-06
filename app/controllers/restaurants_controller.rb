class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: :show

  def index
    @restaurants = Restaurant.search(params)
  end

  def show
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :location, :cuisine, :rating, :price)
  end

end
