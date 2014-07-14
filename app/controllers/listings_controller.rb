class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # GET /listings
  def index
    @listings = Listing.all
    #to handle filters
    if listing_type = params[:listing_type]
      @listings = @listings.where(listing_type: listing_type)
    end
    if listing_type = params[:price]
      @listings = @listings.where(price: price)
    end
    respond_to do |format|
      format.json { render :json @listings, status: 200 }
    end
  end

  # GET /listings/:id
  def show
    respond_to do |format|
      format.json { render :json @listing, status: 200 }
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def set_listing
      @listing = List.find(params[:id])
    end

  def listing_params
    params.require(:listing).permit(:address, :listing_type, :title, :description, :price, :neighborhood, :host)
  end
end
