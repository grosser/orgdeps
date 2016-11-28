source 'https://rubygems.org'

ruby File.read(".ruby-version").strip

gem 'rails', '~> 4.2'
gem 'pg'
gem 'puma'
gem 'omniauth'
gem 'omniauth-github'
gem 'dotenv'
gem 'httparty'
gem 'repo_dependency_graph'
gem 'rack-cache'

# assets
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'bootstrap-sass'

group :production do
  gem 'rails_12factor'
end

group :test do
  gem 'brakeman'
  gem 'minitest-rails'
  gem 'minitest-rg'
  gem 'webmock'
  gem 'mocha', require: 'mocha/setup'
end
