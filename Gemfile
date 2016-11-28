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
gem 'attr_encrypted'

# assets
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'bootstrap-sass'

group :production do
  gem 'rails_12factor'
end

group :test do
  gem 'bundler-audit'
  gem 'brakecheck'
  gem 'brakeman'
  gem 'minitest-rails'
  gem 'minitest-rg'
  gem 'webmock'
  gem 'mocha', require: 'mocha/setup'
end
