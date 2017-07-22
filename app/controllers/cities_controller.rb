class CitiesController < ApplicationController

def index
  @cities = City.all
end

def show
  @city = City.find(params[:id])
  @openings = @city.city_openings(params[:start_date], params[:end_date])
  @neighborhoods = @city.neighborhoods
end

end
