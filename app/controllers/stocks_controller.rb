class StocksController < ApplicationController
  def index
    @stocks = Stock.all.order('id desc')
  end

  def show
    @stock = Stock.find(params[:id])
  end
end
