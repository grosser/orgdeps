require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Orgdeps
  class Application < Rails::Application
    config.load_defaults 5.1
    config.middleware.delete Rack::Lock
    config.middleware.insert_after ActionDispatch::Static, Rack::Cache
    config.action_controller.action_on_unpermitted_parameters = :raise
    config.active_support.deprecation = :raise
  end
end
