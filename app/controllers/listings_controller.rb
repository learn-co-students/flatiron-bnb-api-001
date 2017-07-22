class ListingsController < ApplicationController

  include ActiveModel::Validations

  validates_presence_of :neighborhood_id, :host_id

def index
  if params[:price] != nil
    @listings = Listing.price_filter(params[:price])
  elsif params[:listing_type] != nil
    @listings = Listing.type_filter(params[:listing_type])
  else
    @listings = Listing.all
  end
end

def show
  @listing = Listing.find(params[:id])
end

def create
  listing = Listing.create(listing_params)
  redirect_to "/listings/#{listing.id}", status: 422
end

def update
  listing = Listing.find(params[:id])
  listing.update(listing_params)
  redirect_to "/listings/#{listing.id}", status: 422
end

def destroy
  listing = Listing.find(params[:id])
  listing.delete
  redirect_to "/listings", status: 204
end

  private
    def listing_params
      params.require(:listing).permit(:address, :listing_type, :title, :description, :price, :neighborhood_id, :host_id)
    end

end
