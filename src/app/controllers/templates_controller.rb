class TemplatesController < ApplicationController
  def new
   #uploaded_io = params[:template][:picture]
    #File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
   #   file.write(uploaded_io.read)
   # end
   @template = Template.new
  end
end
