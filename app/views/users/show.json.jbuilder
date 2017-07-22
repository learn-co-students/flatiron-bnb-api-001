
  json.id @user.id

  json.listings @listings do |listing|
    json.address listing.address
  end

  json.reservations @reservations do |reservation|
    json.id reservation.id
  end

  json.res_count @reservations.count

  if @user.hosts != []
    json.trips @user.trips do |trip|
      json.id trip.id
    end

    json.hosts @user.hosts do |host|
      json.name host.name
    end
  end

  if @user.host == true
    json.guests @user.guests do |guest|
      json.name guest.name
    end

    json.host_reviews @user.host_reviews do |review|
      json.id review.id
    end

    json.host_review_count @user.host_reviews.count

  end


