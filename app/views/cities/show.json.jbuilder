json.id @city.id
json.name @city.name
json.neighborhoods @city.neighborhoods
if !@city_openings.nil?
  json.city_openings @city_openings 
end
