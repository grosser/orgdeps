source 'https://rubygems.org'

ruby File.read(".ruby-version").strip

gem 'rails', '~> 5.1.0'
gem 'pg'
gem 'puma', require: false
gem 'omniauth'
gem 'omniauth-github'
gem 'httparty'
gem 'repo_dependency_graph'
gem 'rack-cache'
gem 'attr_encrypted'
gem 'json'

# assets TODO: do not load in prod
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'bootstrap-sass'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'dotenv', require: false
end

group :test do
  gem 'bundler-audit', require: false
  gem 'brakeman', require: false
  gem 'minitest-rails'
  gem 'maxitest'
  gem 'webmock'
  gem 'mocha', require: false
end
