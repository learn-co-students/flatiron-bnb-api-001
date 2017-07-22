class ReviewsController < ApplicationController

  include ActiveModel::Validations

  validates_presence_of :description, :guest_id, :reservation_id

  def index
    @reviews = Review.all
  end

  def create
    review = Review.new(review_params)
    if !review.save
      redirect_to 'reviews#index', status: 422
    else
      redirect_to review
    end
  end

private

  def review_params
    params.require(:review).permit(:description, :rating, :guest_id, :reservation_id)
  end

end
