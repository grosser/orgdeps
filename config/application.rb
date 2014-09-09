require File.expand_path('../boot', __FILE__)
require 'rails/all'

Bundler.require(*Rails.groups)

module Orgdeps
  class Application < Rails::Application
    config.middleware.delete Rack::Lock
    config.middleware.insert_after ActionDispatch::Static, Rack::Cache
  end
end
