require 'test_helper'

class DownloadTest < ActiveSupport::TestCase
  test 'create download' do
    template = Template.new(title: 'test',
      description: 'test',
      filename: 'test',
      category_id: categories(:test).id,
      user_id: users(:test).id
    )
    template.save
    
    @@download = Download.new(user_id: users(:test).id, template_id: template.id)
    assert @@download.save
    
    template.destroy
  end
end
