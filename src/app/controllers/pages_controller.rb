class PagesController < ApplicationController
  def home
    # Recommended
    @recommended = []
    if user_signed_in?
      # Get users downloads
      Download.where(user_id: current_user.id).each do |download|
        # Other users who've downloaded that template
        Download.where('template_id = ? AND user_id != ?', download.template_id, download.user_id).each do |download|
          # Get what the other users downloaded
          Download.where(user_id: download.user_id).each do |download|
            @recommended << Template.find(download.template_id)
          end
        end
      end
    end
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
