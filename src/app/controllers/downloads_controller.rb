class DownloadsController < ApplicationController
  def create
    download_object = {template_id: params[:templateId], user_id: current_user.id}
    
    download = Download.new(download_object)
    download.save
    
    # Check if user has downloaded this already
    if Download.where(download_object)
      render json: false
    else
      render json: true
    end
  end
end
