require "nokogiri"
require "open-uri"

namespace :parse do
  desc "Parsing stock hours"

  task :stock_hours => :environment do
    puts "Parsing stock hours..."

    StockHours.delete_all

    doc = Nokogiri::HTML(open(STOCKS_URL))

    stocks = doc.css("table#public_table div.public_list")

    stocks.each do |s|
      stock_url = EVRASIA_URL + s.at_css("a")['href']
      stock_id = stock_url[/\d+/]

      restaurants = parse_restaurants_and_stock_hours(stock_url)

      restaurants.each do |id, stock_hours|
        Restaurant.find(id).add_stock(stock_id, stock_hours)
      end
    end

    puts 'ok'
  end


  # парсит часы проведения данной акции во всех ресторанах
  # возвращает массив id ресторанов с их часами проведения акции
  def parse_restaurants_and_stock_hours(stock_url)
    restaurants = []

    doc = Nokogiri::HTML(open(stock_url))

    city_list = doc.css("table div.treeview > ul > li")

    city_list.each do |c|
      restaurants_list = c.css("ul > li > ul > li")

      restaurants_list.each do |r|
        id = r.at_css("a")['href'][/\d+/]
        stock_hours = r.at_css("i").nil? ? "всегда" : r.at_css("i").children.text[1..-2]

        # в нижний регистр
        stock_hours = stock_hours.mb_chars.downcase.to_s

        # чистим от мусора
        stock_hours.gsub!(/\s+/, ' ')
        stock_hours.gsub!(/- /, '-')
        stock_hours.gsub!(/\ -/, '-')
        stock_hours.gsub!(/\./, '')

        restaurants.push([id, stock_hours])
      end
    end

    return restaurants
  end
end