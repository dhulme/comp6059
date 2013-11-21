class Template < ActiveRecord::Base
  has_one :category
  has_many :reviews
  has_many :downloads
  
  belongs_to :user
  
  def image_path
    '/uploads/' + self.filename
  end
  
  def preview_path
    '/uploads/' + self.filename + Rails.configuration.preview_extension
  end
  
  def thumbnail_path
    '/uploads/' + self.filename + Rails.configuration.thumbnail_extension
  end
  
  def downloads_text
    num_downloads = downloads
    
    if num_downloads > 1
      num_downloads.to_s + ' downloads'
    else
      if num_downloads == 1
        '1 download'
      else
        'No downloads'
      end
    end
  end
  
  def downloads
    Download.where(template_id: self.id).select(:user_id).distinct.count
  end
  
  def created_at_pretty
    self.created_at.to_formatted_s(:short)
  end
end
