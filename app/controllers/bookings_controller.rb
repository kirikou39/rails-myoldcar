class BookingsController < ApplicationController

  before_action :set_booking, only: [:new, :create, :show]

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
      if @booking.save
        redirect_to booking_path(@booking)
      else
        render 'new'
      end
  end

  def show
    @booking = @car.booking
  end


  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :amount)
  end
  
  def set_booking
  	@car = Car.find(params[:car_id])
  end
end
