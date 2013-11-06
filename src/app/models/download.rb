class Download < ActiveRecord::Base
  has_one :user
  has_one :template
end
