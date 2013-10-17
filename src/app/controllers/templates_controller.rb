class TemplatesController < ApplicationController
  require 'securerandom'
  
  def index
    @templates = Template.find(:all, order: 'category_id')
    @categories = Category.all
    
    @categorised_templates = {
      x: 'f'
    }
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
    @image_path = '/uploads/' +  @template.filename
    @category = Category.find(@template.category_id)
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
