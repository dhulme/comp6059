class PagesController < ApplicationController
  def home
    
  end
  
  def setup_categories
    categories = [Category.new(name: 'Logos'),
      Category.new(name: 'Posters')]
    
    categories.each do |category|
      category.save
    end
    
    render inline: 'Done'
  end
end
