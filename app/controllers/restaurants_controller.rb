class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: [:show, :edit, :create, :destroy]

  def index
    @restaurants = Restaurant.all
  end

  def show
    #find_restaurant
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new
    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      flash[:errors] = @restaurant.errors.full_messages
      redirect_to new_restaurant_path
    end
  end

  def edit
    #find_restaurant
  end

  def update
    #find_restaurant
    if @restaurant.update
      redirect_to restaurant_path(@restaurant)
    else
      flash[:errors] = @restaurant.errors.full_messages
      redirect_to edit_restaurant_path
    end
  end

  def destroy
    #find_restaurant
    restaurant.destroy
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :location, :cuisine, :rating, :price)
  end

end
