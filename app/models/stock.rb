class Stock < ActiveRecord::Base
  has_many :stock_hours
  has_many :restaurants, :through => :stock_hours

  def original_link
    return "http://evrasia.spb.ru/public/akcii/view/#{id}.html"
  end
end
