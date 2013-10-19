class Template < ActiveRecord::Base
  has_one :category
  
  def image_path
    '/uploads/' + self.filename
  end
  
  def downloads_text
    if self.downloads > 1
      self.downloads.to_s + ' downloads'
    else
      if self.downloads == 1
        '1 download'
      else
        'No downloads'
      end
    end
  end
end
