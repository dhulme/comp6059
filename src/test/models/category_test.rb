require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'create category' do
    @@category = Category.new(name: 'test')
    assert @@category.save
  end
  
  test 'remove category' do
    assert @@category.destroy
  end
end
