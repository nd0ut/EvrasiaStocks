class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all

    respond_to do |f|
      f.html
      f.json { render :json =>
          @restaurants.to_json(
              :include => :city
          )
      }
    end
  end

  def show
    @restaurant = Restaurant.find(params['id'])
  end
end
