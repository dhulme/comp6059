class TemplatesController < ApplicationController
  require 'securerandom'
  respond_to :html, :json
  
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
    Download.select('template_id, count(distinct user_id) as downloads_count').group('template_id').order('downloads_count DESC').each do |download|
      template = Template.find(download.template_id)
      @popular[template.category_id] << template
    end
    
    # Highly rated
    Template.joins(:reviews).order('rating DESC').limit(3).distinct.each do |template|
      @rated[template.category_id] << template
    end
    
    # Newest
    Template.order('created_at DESC').limit(3).each do |template|
      @newest[template.category_id] << template
    end
    
    @categories = Category.all
  end
  
  def new
    #before_filter :authenticate_user!
  end
  
  def create
    @template = Template.new(template_params)
    
    # Set creator
    @template.user = current_user
    
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
    @creator = User.find(@template.user_id)
    @reviews = Review.where('template_id = ?', params[:id]).order('created_at DESC')
  end
  
  def search
    @templates = Template.search params[:term]
    
    respond_with @templates
  end
  
  private
    def template_params
      params.require(:template).permit(:title, :description, :category_id)
    end
end
