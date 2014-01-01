class ReviewsController < ApplicationController
  respond_to :json
  
  def create
    # Check user hasn't already reviewed the template, or not downloaded it
    @template = Template.find(review_params.template_id)
    if @template.has_user_reviewed? current_user or !@template.has_user_downloaded? current_user
      return
    end
    
    @review = Review.new(review_params)
    @review.user = current_user
    @review.save
    
    respond_with @review
  end
  
  private
    def review_params
      params.require(:review).permit(:rating, :comment, :template_id)
    end
end
