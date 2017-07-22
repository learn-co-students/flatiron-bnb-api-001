json.id @listing.id
json.average_rating @listing.average_rating

json.reviews @listing.reviews do |review|
  json.description review.description
end

json.reservations @listing.reservations do |reservation|
  json.id reservation.id
end
