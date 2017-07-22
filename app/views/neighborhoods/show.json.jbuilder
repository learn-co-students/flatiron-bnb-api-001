json.id @neighborhood.id
json.name @neighborhood.name
json.city_id @neighborhood.city_id

if @listings != nil
  json.neighborhood_openings @listings do |listing|
    json.id listing.id
  end
end