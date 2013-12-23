class CategoriesController < ApplicationController
  before_filter :authenticate_user!,
    :except => []
  
  def index
    @categories = Category.all
  end
  
  def create
    @category = Category.new(category_params)
    
    @category.save
    redirect_to '/categories'
  end
  
  def update
    @category = Category.find(params[:id])
    
    if @category.update(category_params)
      render status: 200, json: @category.to_json
    end
  end
  
  private
    def category_params
      params.require(:category).permit(:name)
    end
end