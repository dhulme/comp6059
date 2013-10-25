class TemplatesController < ApplicationController
  require 'securerandom'
  
  def index
    @popular = {}
    @rated = {}
    @newest = {}
    Category.all.each do |category|
      @popular[category.id] = []
      @newest[category.id] = []
      @rated[category.id] = []
    end
    
    # Most popular
    Template.order('downloads DESC').limit(3).each do |template|
      @popular[template.category_id] << template
    end
    
    # Highly rated
    
    # We should be able to do a nicer join...
    Template.joins(:reviews).order('rating DESC').limit(3).each do |template|
    #Template.find_by_sql('SELECT templates.*, reviews.rating FROM templates, reviews
    #  WHERE templates.id = reviews.template_id
    #  ORDER BY reviews.rating DESC
    #  LIMIT 3').each do |template|
      #puts template.inspect
      puts template.reviews
      @rated[template.category_id] << template
    end
    
    # Newest
    Template.order('created_at DESC').limit(3).each do |template|
      @newest[template.category_id] << template
    end
    
    @categories = Category.all
  end
  
  def new
  end
  
  def create
    @template = Template.new(template_params)
    
    # Upload image file
    # From http://guides.rubyonrails.org/form_helpers.html#uploading-files
    uploaded_io = params[:template][:image]
    @template.filename = SecureRandom.uuid
    File.open(Rails.root.join('public', 'uploads', @template.filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    
    @template.save
    redirect_to @template
  end
  
  def show
    @template = Template.find(params[:id])
    @category = Category.find(@template.category_id)
    @reviews = Review.where('template_id = ?', params[:id]).order('created_at DESC')
  end
  
  def download
    @template = Template.find(params[:id])
    @template.increment(:downloads)
    @template.save
    
    respond_to do |format|
      format.json {
        render :json => true
      }
    end
  end
  
  private
    def template_params
      params.require(:template).permit(:title, :description, :category_id)
    end
end
