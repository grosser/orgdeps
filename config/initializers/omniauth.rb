require 'omniauth'
require 'omniauth-github'

OmniAuth.config.logger = Rails.logger

unless Rails.env.test? # TODO: should not need this but raises weird errors
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_SECRET"], :scope => "user:email,read:org"
  end
end
