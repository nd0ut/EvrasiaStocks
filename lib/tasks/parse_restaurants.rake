require "nokogiri"
require "open-uri"

namespace :parse do
  desc "Parsing restaurants"

  EVRASIA_URL = "http://www.evrasia.spb.ru"

  task :restaurants => :environment do
    Restaurant.delete_all

    doc = Nokogiri::HTML(open(EVRASIA_URL))

    cities_a = doc.css("li#menu_list_24 > ul > li > a")

    cities_a.each do |city_a|
      city_url = EVRASIA_URL + city_a['href']

      parse_city_url(city_url)
    end

  end

  def parse_city_url(city_url)
    doc = Nokogiri::HTML(open(city_url))

    city_id = city_url[/\d+/].to_i

    restaurants = doc.css("div#treeview a")

    restaurants.each do |r|
      r_url =  EVRASIA_URL + r['href']

      parse_restaurant_url(r_url, city_id)
    end
  end

  def parse_restaurant_url(restaurant_url, city_id)
    doc = Nokogiri::HTML(open(restaurant_url))

    info = doc.css("div.content > table > tr > td")[1]

    id = restaurant_url[/\d+/].to_i
    title = info.css("p")[1].css("strong").children.text
    street = info.css("p")[0].children.text
    metro = info.css("p")[1].children.text[/(?<=метро: )(.*)(?=\r\n)/]
    phone = info.css("p")[1].children.text[/(?<=Тел.: )(.*)(?=\r\n)/]
    business_hours = info.css("p")[1].children.text[/(?<=работы: )(.*)(?=\r\n)/]

    Restaurant.create! id: id,
                       city_id: city_id,
                       title: title,
                       street: street,
                       metro: metro,
                       phone: phone,
                       business_hours: business_hours
  end
end