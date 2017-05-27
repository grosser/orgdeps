ENV['RAILS_ENV'] = 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/rails'
require 'maxitest/autorun'
require 'webmock/minitest'
require 'mocha/setup'

ActiveSupport::TestCase.class_eval do
  fixtures :all
end

ActionDispatch::IntegrationTest.class_eval do
  let(:described_class) do
    self.class.ancestors.detect do |a|
      described = a.instance_variable_get(:@desc)
      break described if described.is_a?(Class)
    end
  end

  def login_as(user)
    described_class.any_instance.stubs(session: {user_id: user.id})
  end

  # bring back helper that was removed in rails 5
  def assigns(name)
    @controller.instance_variable_get(:"@#{name}")
  end
end
