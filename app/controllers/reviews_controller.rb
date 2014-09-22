class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
    respond_to do |format|
      format.json
    end
  end 

  def create
    @review = Review.create(review_params)
    if @review.save
      render json: @review, status: 201, location: @reviews
    else
      render json: @review.errors, status: 422
    end
  end

  private 
  def review_params
    params.require(:review).permit(:description, :rating, :guest_id, :reservation_id)
  end

end
