class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :update, :destroy]

  # GET /listings
  def index
    @listings = Listing.all
    # /listings.json?listing_type=private%20room
    if listing_type = params[:listing_type]
      @listings = @listings.where(listing_type: listing_type)
    end
    if price = params[:price]
      @listings = @listings.where(price: price)
    end
    respond_to do |format|
      format.json
    end
  end

  # GET /listings/:id
  def show
    respond_to do |format|
      format.json
    end
  end

  # POST /listings
  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      render json: @listing, status: 201, location: @listing
    else
      render json: @listing.errors, status: 422
    end
  end

  # PATCH /listings/:id
  def update
    if @listing.update(listing_params)
      render json: @listing, status: 200
    else
      render json: @listing.errors, status: 422
    end
  end

  # DELETE /listings/:id
  def destroy
    @listing.destroy
    head 204
  end

  private
  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:address, :listing_type, :title, :description, :price, :neighborhood_id, :host_id)
  end
end
