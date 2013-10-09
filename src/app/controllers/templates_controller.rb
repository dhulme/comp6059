class TemplatesController < ApplicationController
  def new
   @template = Template.new
  end
  
  def create
    logger.info 'uploading'
    uploaded_io = params[:template][:picture]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end
end
