class CarsController < ApplicationController
  before_action :set_car, only: [:show, :destroy]

  def index
    @cars = Car.all
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.save

    # Redirect to ???
    redirect_to car_path(@car)
  end

  def show
  end

  def destroy
    @car.destroy

    # Redirect
    redirect_to user_path(@user)
  end

  private

  def car_params
    params.require(:car).permit(:name, :price, :model, :year, :address, :transmission, :engine_type, :kilometers, :user)
  end

  def set_car
    @car = Car.find(params[:id])
  end
end
