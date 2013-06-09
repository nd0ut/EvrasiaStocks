class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.includes(:city).load

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @restaurant = Restaurant.includes(:stock_hours).find(params[:id])

    respond_to do |format|
      format.html
      format.json
    end
  end
end
