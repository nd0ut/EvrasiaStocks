require "nokogiri"
require "open-uri"

namespace :parse do
  desc "Parsing cities"

  EVRASIA_URL = "http://www.evrasia.spb.ru"

  task :cities => :environment do
    City.delete_all

    doc = Nokogiri::HTML(open(EVRASIA_URL))

    cities = doc.css("li#menu_list_24 > ul > li > a")

    cities.each do |c|
      c_id = c['href'][/\d+/].to_i
      c_name = c.children.text

      City.create! id: c_id, name: c_name
    end

  end

end