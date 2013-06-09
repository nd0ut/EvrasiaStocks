class StocksController < ApplicationController
  def index
    @stocks = Stock.all.order('id desc')

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @stock = Stock.includes(:restaurants => :city).find(params[:id])

    @ordered_restaurants = @stock.restaurants.sort do |a, b|
      # TODO: блять, тут пиздец как неоптимизированно, но я не знаю как иначе :(
      a_now = @stock.stock_hours.find_by_restaurant_id(a.id).now?

      a_now ? -1 : 1
    end

    respond_to do |format|
      format.html
      format.json
    end
  end
end
