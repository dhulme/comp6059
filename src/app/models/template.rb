class Template < ActiveRecord::Base
  has_one :category
  has_many :reviews
  
  belongs_to :user
  
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
  
  def created_at_pretty
    self.created_at.to_formatted_s(:short)
  end
end
