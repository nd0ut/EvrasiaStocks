require "nokogiri"
require "open-uri"

namespace :parse do
  desc "Parsing cities"

  task :cities => :environment do
    puts "Parsing cities..."

    City.delete_all

    doc = Nokogiri::HTML(open(EVRASIA_URL))

    city_list = doc.css("li#menu_list_24 > ul > li > a")

    city_list.each do |c|
      id = c['href'][/\d+/].to_i
      name = c.children.text

      City.create! id: id,
                   name: name
    end

    puts 'ok'

  end

end