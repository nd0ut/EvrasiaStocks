require "nokogiri"
require "open-uri"

namespace :parse do
  desc "Parsing stocks"


  task :stocks => :environment do
    puts "Parsing stocks..."

    Stock.delete_all

    doc = Nokogiri::HTML(open(STOCKS_URL))

    stocks = doc.css("table#public_table div.public_list")

    stocks.each do |s|
      url = EVRASIA_URL + s.at_css("a")['href']
      id = url[/\d+/]
      title = s.css("div > a").children.text
      description = parse_stock_description(url)
      image_url = EVRASIA_URL + s.at_css("a > img")['src']

      Stock.create! id: id,
                    title: title,
                    description: description,
                    image_url: image_url

    end

    puts 'ok'
  end

  def parse_stock_description(stock_url)
    doc = Nokogiri::HTML(open(stock_url))

    description = String.new

    doc.css("div.public_view > p").each do |d|
      description += d.children.text + "<BR><BR>";
    end

    return description
  end
end