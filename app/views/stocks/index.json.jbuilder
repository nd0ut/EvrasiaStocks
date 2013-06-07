json.array!(@stocks) do |s|
  json.id s.id
  json.title s.title
  json.description s.description
end