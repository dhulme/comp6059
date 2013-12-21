class Review < ActiveRecord::Base
  has_one :template
  belongs_to :user
  
  def created_at_pretty
    self.created_at.to_formatted_s(:short)
  end
  
  def stars_html
    html = ''
    for i in 0..4
      if i < self.rating
        html += '<span class="glyphicon glyphicon-star"></span>'
      else
        html += '<span class="glyphicon glyphicon-star-empty"></span>'
      end
    end
    html
  end
end
