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
    @restaurant = Restaurant.find_by(id: params['id'])
  end
end
