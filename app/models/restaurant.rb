class Restaurant < ActiveRecord::Base
  belongs_to :city

  has_many :stock_hours
  has_many :stocks, :through => :stock_hours

  validates :city_id, :presence => true
  validates :title, :presence => true
  validates :street, :presence => true

  def add_stock(stock_id, hours)
    self.stock_hours.create! stock_id: stock_id,
                             restaurant_id: self.id,
                             hours: hours
  end

  def original_link
    return "http://evrasia.spb.ru/address/view/#{id}.html"
  end
end
