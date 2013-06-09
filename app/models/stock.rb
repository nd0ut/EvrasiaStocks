class Stock < ActiveRecord::Base
  has_many :stock_hours
  has_many :restaurants, :through => :stock_hours

  validates :title, :presence => true
  validates :description, :presence => true
  validates :image_url, :presence => true
  validates :image_url, :format => {:with => /(https?:\/\/.*\.(?:png|jpg))/}

  def original_link
    return "http://evrasia.spb.ru/public/akcii/view/#{id}.html"
  end
end
