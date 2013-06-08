require "nokogiri"
require "open-uri"

namespace :parse do
  desc "Parsing restaurants"

  task :restaurants => :environment do
    puts "Parsing restaurants..."

    Restaurant.delete_all

    doc = Nokogiri::HTML(open(EVRASIA_URL))

    city_list = doc.css("li#menu_list_24 > ul > li > a")

    city_list.each do |city|
      city_url = EVRASIA_URL + city['href']

      city_restaurants = parse_city_url(city_url)

      city_restaurants.each do |r|
        Restaurant.create! id: r[:id],
                           city_id: r[:city_id],
                           title: r[:title],
                           street: r[:street],
                           metro: r[:metro],
                           phone: r[:phone],
                           business_hours: r[:business_hours]
      end
    end

    puts 'ok'
  end

  # парсит информацию о ресторанах в данном городе
  # возвращает массив ресторанов
  def parse_city_url(city_url)
    doc = Nokogiri::HTML(open(city_url))

    restaurants = []

    restaurant_list = doc.css("div#treeview a")

    restaurant_list.each do |r|
      # ссылка на ресторан
      url = EVRASIA_URL + r['href']

      # парсинг инфы о нем
      restaurant = parse_restaurant_url(url)

      # добавление в общиий массив
      restaurants.push restaurant
    end

    # получаем id города
    city_id = city_url[/\d+/].to_i

    # добавляем к каждому ресторану
    restaurants.each do |r|
      r[:city_id] = city_id
    end

    return restaurants
  end

  # парсит информацию о ресторане
  def parse_restaurant_url(restaurant_url)
    doc = Nokogiri::HTML(open(restaurant_url))

    info = doc.css("div.content > table > tr > td")[1]

    id = restaurant_url[/\d+/].to_i
    title = info.css("p")[1].css("strong").children.text.strip
    street = info.css("p")[0].children.text.strip
    metro = info.css("p")[1].children.text[/(?<=метро: )(.*)(?=\r\n)/].strip
    phone = info.css("p")[1].children.text[/(?<=Тел.: )(.*)(?=\r\n)/].strip
    business_hours = info.css("p")[1].children.text[/(?<=работы: )(.*)(?=\r\n)/].strip

    return {id: id,
            title: title,
            street: street,
            metro: metro,
            phone: phone,
            business_hours: business_hours
    }
  end
end