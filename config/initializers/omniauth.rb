require 'omniauth'
require 'omniauth-github'

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_SECRET"], :scope => "user,read:org"
end
