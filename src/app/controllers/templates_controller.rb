class TemplatesController < ApplicationController
  def new
  end
  
  def create
    @template = Template.new(template_params)
    
    @template.save
    redirect_to @template
  end
  
  def show
    @template = Template.find(params[:id])
  end
  
  private
    def template_params
      params.require(:template).permit(:title, :description)
    end

  
  def design
    logger.info @template
    # From http://guides.rubyonrails.org/form_helpers.html#uploading-files
    uploaded_io = params[:template][:picture]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end
end
