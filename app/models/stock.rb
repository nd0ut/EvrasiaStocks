class Stock < ActiveRecord::Base
  has_many :stock_hours
  has_many :restaurants, :through => :stock_hours

  def originalLink
    return "http://evrasia.spb.ru/public/akcii/view/#{id}.html"
  end
end
