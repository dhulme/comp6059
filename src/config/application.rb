require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Src
  class Application < Rails::Application
    Rails.configuration.preview_size = '300x300'
    Rails.configuration.preview_extension = '-preview'
    
    Rails.configuration.thumbnail_size = '100x100'
    Rails.configuration.thumbnail_extension = '-thumb'
  end
end