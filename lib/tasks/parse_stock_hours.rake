require "nokogiri"
require "open-uri"

namespace :parse do
  desc "Parsing stock hours"

  EVRASIA_URL = "http://www.evrasia.spb.ru"
  STOCKS_URL = EVRASIA_URL + '/public/akcii.html'

  task :stock_hours => :environment do
    StockHours.delete_all

    doc = Nokogiri::HTML(open(STOCKS_URL))

    stocks = doc.css("table#public_table div.public_list")

    stocks.each do |s|
      s_url =  EVRASIA_URL + s.at_css("a")['href']
      s_id = s_url[/\d+/]

      restaurants = parse_stock_url_for_restaurants(s_url)

      restaurants.each do |id, hours|
        Restaurant.find_by(id: id).addStock(s_id, hours)
      end
    end

  end

  def parse_stock_url_for_restaurants(stock_url)
    restaurants = []

    doc = Nokogiri::HTML(open(stock_url))

    city_list = doc.css("table div.treeview > ul > li")

    city_list.each do |c|
      c_name = c.at_css("span").children.text
      c_id = City.find_by_name(c_name).id

      c_restaurants_list = c.css("ul > li > ul > li")

      c_restaurants_list.each do |c_r|
        c_r_id = c_r.at_css("a")['href'][/\d+/]
        c_r_hours = c_r.at_css("i").nil? ? "всегда" : c_r.at_css("i").children.text[1..-2]

        restaurants.push([c_r_id, c_r_hours])
      end
    end

    return restaurants
  end
end