class ReviewsController < ApplicationController
  respond_to :json
  
  def create
    @review = Review.new(review_params)
    @review.save
    
    respond_with @review
  end
  
  private
    def review_params
      params.require(:review).permit(:rating, :comment, :template_id)
    end
end
