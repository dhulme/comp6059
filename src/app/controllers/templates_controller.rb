class TemplatesController < ApplicationController
  require 'securerandom'
  respond_to :html, :json
  
  before_filter :authenticate_user!,
    :only => [:new, :create, :update, :destroy]
  
  def index
    # Pass through search string
    @search = params[:search]
    
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
    
    # Also return all templates
    @templates = Template.all
  end
  
  def new
    
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
      # Create full size file, preview and thumbnail versions
      file.write(uploaded_io.read)
      system "convert #{file.path} -resize #{Rails.configuration.preview_size} #{file.path}#{Rails.configuration.preview_extension}"
      system "convert #{file.path} -resize #{Rails.configuration.thumbnail_size} #{file.path}#{Rails.configuration.thumbnail_extension}"
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
  
  def update
    # Only update if admin
    if current_user.admin?
      @template = Template.find(params[:id])

      if @template.update(template_params)
        render status: 200, json: @template.to_json
      end
    end
  end
  
  def destroy
    # Only delete if admin
    if current_user.admin?
      @template = Template.find(params[:id]).destroy
      
      render status: 200, json: true
    end
  end
  
  def search
    @templates = Template.search params[:term]
    
    respond_with @templates
  end
  
  # From http://stackoverflow.com/questions/3951235/how-do-i-make-an-rss-atom-feed-in-rails-3
  def feed
    @title = 'Templates'
    @templates = Template.order('created_at DESC')
    @updated = @templates.first.created_at unless @templates.empty?
    
    respond_to do |format|
      format.atom { render :layout => false}
      
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
  end
  
  private
    def template_params
      params.require(:template).permit(:title, :description, :category_id)
    end
end
