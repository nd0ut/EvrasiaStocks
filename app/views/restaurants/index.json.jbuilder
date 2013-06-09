json.array!(@restaurants) do |r|
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
      stock_hours = s.stock_hours.find_by_stock_id(s.id)

      json.id s.id
      json.hours stock_hours.hours
      json.now stock_hours.now?
    end
  end
end