class NeighborhoodsController < ApplicationController

  def index
    @neighborhoods = Neighborhood.all
  end

  def show
    @neighborhood = Neighborhood.find(params[:id])

    if params[:start_date] != nil && params[:end_date] != nil
      @listings = @neighborhood.neighborhood_openings(params[:start_date], params[:end_date])
    end
    
  end

end
