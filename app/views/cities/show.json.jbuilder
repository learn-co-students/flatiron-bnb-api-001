json.id @city.id
json.name @city.name

json.city_openings do 
  json.array! @openings do |listing|
    json.id listing.id
  end
end

json.neighborhoods do
  json.array! @neighborhoods do |neighborhood|
    json.name neighborhood.name
  end
end

