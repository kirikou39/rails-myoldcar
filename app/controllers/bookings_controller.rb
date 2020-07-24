class BookingsController < ApplicationController

  before_action :set_car, only: [:new, :create, :show]

  def index
    @bookings = Booking.where(user: current_user)
  end

  def new
    @booking = Booking.new
    @booking.car = @car
    
    @count_rating = count_ratings(@car)
    @avg_rating = avg_rating(@car)
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
  
  def set_car
  	@car = Car.find(params[:car_id])
  end

  def count_ratings(car)
    @count_ratings = car.reviews.count
  end

  def avg_rating(car)
    sum = 0

    # Summing all the ratings
    car.reviews.each do |review|
      sum += review.rating
    end

    # Computing  and returning the average
    if count_ratings(car) > 0
      @avg_rating = sum / count_ratings(car)
    else
      @avg_rating = 0
    end
  end
end
