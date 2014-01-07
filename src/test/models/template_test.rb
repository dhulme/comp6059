require 'test_helper'

class TemplateTest < ActiveSupport::TestCase
  test 'create template' do
    @@template = Template.new(title: 'test',
      description: 'test',
      filename: 'test',
      category_id: categories(:test).id,
      user_id: users(:test).id
    )
    assert @@template.save
  end
  
  test 'remove template' do
    assert @@template.destroy
  end
end
