class Restaurant < ActiveRecord::Base
  belongs_to :city

  has_many :stock_hours
  has_many :stocks, :through => :stock_hours

  def addStock(stock_id, stock_hours)
    self.stock_hours.create! stock_id: stock_id,
                             restaurant_id: self.id,
                             hours: stock_hours
  end

  def originalLink
    return "http://evrasia.spb.ru/address/#{id}.html"
  end
end
