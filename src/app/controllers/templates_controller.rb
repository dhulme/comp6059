class TemplatesController < ApplicationController
  require 'securerandom'
  
  def index
    @templates = Template.all
  end
  
  def new
  end
  
  def create
    logger.info template_params
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
  end
  
  private
    def template_params
      params.require(:template).permit(:title, :description)
    end
end
