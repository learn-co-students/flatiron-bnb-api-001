class NeighborhoodsController < ApplicationController

  def index
    @neighborhoods = Neighborhood.all
    respond_to do |format|
      format.json
    end
  end

  def show
    @neighborhood = Neighborhood.find(params[:id])
    respond_to do |format|
      format.json
      if start_date = params[:start_date] && end_date = params[:end_date]
        @neighborhood_openings = @neighborhood.neighborhood_openings(start_date, end_date)
      end
    end
  end
end
