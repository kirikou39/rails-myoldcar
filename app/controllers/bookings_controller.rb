class BookingsController < ApplicationController

  before_action :set_car, only: [:new, :create, :show]
  before_action :set_booking, only: [:show, :destroy]

  def index
    @bookings = Booking.where(user: current_user)
  end

  def new
    @booking = Booking.new
    @booking.car = @car

    set_up_new_form
    
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.amount = (((@booking.end_date - @booking.start_date).to_i / (60 * 60 * 24)) + 1) * @car.price
    # binding.pry
    @booking.car = @car
    @booking.user = current_user
    if @booking.save
      flash[:notice] = "Booking succesfully created!"
      redirect_to car_booking_path(@car, @booking)
    else
      flash[:alert] = "Something went wrong. The booking has not been created!"
      
      set_up_new_form
      render :new
    end
  end

  def show
  end


  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :amount)
  end
  
  def set_car
  	@car = Car.find(params[:car_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def count_ratings(car)
    count_ratings = car.reviews.count
  end

  def avg_rating(car)
    sum = 0

    # Summing all the ratings
    car.reviews.each do |review|
      sum += review.rating
    end

    # Computing  and returning the average
    if count_ratings(car) > 0
      avg_rating = sum / count_ratings(car)
    else
      avg_rating = 0
    end
  end

  def set_up_new_form
    @count_rating = count_ratings(@car)
    @avg_rating = avg_rating(@car)
    @booking.amount = nil  
  end
end
