class StockHours < ActiveRecord::Base
  belongs_to :stock
  belongs_to :restaurant
end
