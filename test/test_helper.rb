ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'webmock/minitest'

ActiveSupport::TestCase.class_eval do
  fixtures :all
end

ActionController::TestCase.class_eval do
  def login_as(user)
    session[:user_id] = user.id
  end
end
