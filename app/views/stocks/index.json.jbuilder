json.array!(@stocks) do |s|
  json.id s.id
  json.title s.title
  json.description s.description
  json.image_url s.image_url
end