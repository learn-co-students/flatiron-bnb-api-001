json.id @neighborhood.id
json.name @neighborhood.name
json.city @neighborhood.city
if !@neighborhood_openings.nil?
  json.neighborhood_openings @neighborhood_openings 
end