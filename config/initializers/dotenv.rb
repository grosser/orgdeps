unless Rails.env.production?
  require 'dotenv'
  Dotenv.load(Bundler.root.join('.env'))
end
