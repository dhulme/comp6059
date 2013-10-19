class Template < ActiveRecord::Base
  has_one :category
  
  def image_path
    '/uploads/' + self.filename
  end
end
