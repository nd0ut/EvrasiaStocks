class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])

    respond_to do |format|
      format.html
      format.json
    end
  end
end
