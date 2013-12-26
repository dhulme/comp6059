class DownloadsController < ApplicationController
  def create
    download_object = {template_id: params[:templateId], user_id: current_user.id}
    
    # Check if user has downloaded this already
    if Download.where(download_object).exists?
      return render json: false
    end
    
    download = Download.new(download_object)
    download.save
   
    render json: true
  end
end
