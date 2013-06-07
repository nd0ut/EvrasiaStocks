r = @restaurant

json.id r.id
json.title r.title

json.info do
  json.city r.city.name
  json.street r.street
  json.metro r.metro
  json.phone r.phone
  json.business_hours r.business_hours
end

json.stocks do
  json.array!(r.stocks) do |s|
    json.id s.id
    json.hours s.stock_hours.find_by_stock_id(s.id).hours
  end
end