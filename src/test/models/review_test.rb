require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  test 'create review' do
    template = Template.new(title: 'test',
      description: 'test',
      filename: 'test',
      category_id: categories(:test).id,
      user_id: users(:test).id
    )
    template.save
    
    @@review = Review.new(rating: 4,
      template_id: template.id,
      user_id: users(:test).id
    )
    assert @@review.save
    
    template.destroy
  end
end
