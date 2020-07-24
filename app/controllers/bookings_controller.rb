class BookingsController < ApplicationController

  before_action :set_car, only: [:new, :create, :show]
  before_action :set_booking, only: [:show]

  def index
    @bookings = Booking.where(user: current_user)
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.amount = (@booking.end_date - @booking.start_date).to_i * @car.price
    @booking.car = @car
    @booking.user = current_user
      if @booking.save
        redirect_to car_booking_path(@car, @booking)
      else
        render 'new'
      end
  end

  def show
    @cars = Car.geocoded

    @markers = @cars.map do |car|
      {
        lat: car.latitude,
        lng: car.longitude
      }
    end
end


  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
  
  def set_car
  	@car = Car.find(params[:car_id])
  end
  
  def set_booking
    @booking = Booking.find(params[:id])
  end
end
