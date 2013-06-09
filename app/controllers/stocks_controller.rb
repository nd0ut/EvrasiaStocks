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

    respond_to do |format|
      format.html
      format.json
    end
  end
end
