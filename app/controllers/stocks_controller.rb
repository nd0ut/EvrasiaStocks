class StocksController < ApplicationController
  def index
    @stocks = Stock.all.order('id desc')
  end

  def show
    @stock = Stock.find_by(id: params['id'])
  end
end
