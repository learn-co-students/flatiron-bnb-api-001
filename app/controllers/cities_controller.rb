class CitiesController < ApplicationController

  def index
    @cities = City.all
    respond_to do |format|
      format.json
    end
  end

  def show
    @city = City.find(params[:id])
    respond_to do |format|
      format.json
      if start_date = params[:start_date] && end_date = params[:end_date]
        @city_openings = @city.city_openings(start_date, end_date)
      end
    end
  end

  def most_res
    respond_to do |format|
      format.json
    end
  end

  def highest_ratio_res_to_listings
  end

end
