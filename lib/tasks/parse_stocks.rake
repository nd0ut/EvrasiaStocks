require "nokogiri"
require "open-uri"

namespace :parse do
  desc "Parsing stocks"

  EVRASIA_URL = "http://www.evrasia.spb.ru"
  STOCKS_URL = EVRASIA_URL + '/public/akcii.html'

  task :stocks => :environment do
    puts "Parsing stocks..."

    Stock.delete_all

    doc = Nokogiri::HTML(open(STOCKS_URL))

    stocks = doc.css("table#public_table div.public_list")

    stocks.each do |s|
      s_url =  EVRASIA_URL + s.at_css("a")['href']
      s_id = s_url[/\d+/]
      s_title = s.css("div > a").children.text
      s_description = parse_stock_description(s_url)
      s_image_url = EVRASIA_URL + s.at_css("a > img")['src']

      Stock.create! id: s_id,
                    title: s_title,
                    description: s_description,
                    image_url: s_image_url

    end

    puts 'ok'
  end

  def parse_stock_description(stock_url)
    doc = Nokogiri::HTML(open(stock_url))

    description = ""

    doc.css("div.public_view > p").each do |d|
      description += d.children.text + "<BR><BR>";
    end

    return description
  end
end