source 'https://rubygems.org'

ruby File.read(".ruby-version").strip

gem 'rails', '~> 5.1.0'
gem 'pg'
gem 'puma', require: false
gem 'omniauth'
gem 'omniauth-github', git: "https://github.com/omniauth/omniauth-github.git" # needs >1.3.0
gem 'repo_dependency_graph'
gem 'rack-cache'
gem 'attr_encrypted'
gem 'json'
gem 'airbrake'
gem 'airbrake-user_informer'

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
