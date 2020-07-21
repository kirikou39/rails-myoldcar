class ReviewsController < ApplicationController
  before_action :set_car, only: [:new, :create]
  before_action :set_review, only: [:show, :destroy]

  def index
    @reviews = Review.where(user: current_user, car: set_car)
  end
  
  def show
  end

  def new
    @review = Review.new
    @review.car = @car
  end

  def create
    @review = Review.new(review_params)
    @review.car = @car
    if @review.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def destroy
    @review.destroy

    # Redirect to user dashboard
    redirect_to user_path(current_user)
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
