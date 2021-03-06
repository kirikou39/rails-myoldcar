class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :show, :index]

  def home
    if params[:query].present?
      @cars = Car.search_by_name_and_year(params[:query])
    else
      @cars = Car.all
      @some_cars = Car.first(3)
    end
  end
end
