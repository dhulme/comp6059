class PagesController < ApplicationController
  def home
    
  end
  
  def setup_categories
    Category.delete_all
    
    categories = [Category.new(name: 'Logos'),
      Category.new(name: 'Posters')]
    
    categories.each do |category|
      category.save
    end
    
    render inline: '<h2>Added categories to database.</h2>'
  end
end
