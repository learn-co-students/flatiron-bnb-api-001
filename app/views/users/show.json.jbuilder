json.id @user.id
json.name @user.name
json.host @user.host

if @user.host = true
  json.listings @user.listings
end

json.reservations @user.reservations
json.trips @user.trips
json.reviews @user.reviews
json.res_count @user.reservations.count

if !@user.guests.empty?
  json.guests @user.guests
end

if !@user.hosts.empty?
  json.hosts @user.hosts
end

if !@user.host_reviews.empty?
  json.host_reviews @user.host_reviews
  json.host_review_count @user.host_reviews.count
elsif @user.host_reviews.empty?
  json.host_review_count @user.host_reviews.count
end

#TODO: refactor into partials