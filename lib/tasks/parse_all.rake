namespace :parse do
  desc "Parsing all"

  EVRASIA_URL = "http://www.evrasia.spb.ru"
  STOCKS_URL = EVRASIA_URL + '/public/akcii.html'

  task :all => :environment do
    Rake::Task['parse:cities'].execute
    Rake::Task['parse:stocks'].execute
    Rake::Task['parse:restaurants'].execute
    Rake::Task['parse:stock_hours'].execute
  end

end