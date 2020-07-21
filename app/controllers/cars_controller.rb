class CarsController < ApplicationController

  before_action :set_car, only: [:show, :destroy]

  def index
    if params[:query].present?
      @cars = Car.search_by_name_and_year(params[:query])
    else
      @cars = Car.all
    end
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    set_car_user
    if @car.save
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  def show
    sum = 0
    @count_rating = 0
    @car.reviews.each do |review|
      sum += review.rating
      @count_rating += 1 
    end
    if @count_rating > 0
      @avg_rating = sum / @count_rating
    else
      @avg_rating = 0
    end
  end

  def destroy
    @car.destroy

    # Redirect
    redirect_to user_path(current_user)
  end

  private

  def car_params
    params.require(:car).permit(:name, :price, :model, :year, :address, :transmission, :engine_type, :kilometers, :user, photos: [])
  end

  def set_car
    @car = Car.find(params[:id])
  end

  def set_car_user
    @car.user = current_user
  end

end
