source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 4.3'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Rubocop (directly from git source)
gem 'rubocop', git: 'https://github.com/bbatsov/rubocop'

# Devise (w/ token authentication)
gem 'devise'
gem 'devise_token_auth'

# CanCanCan gem used for authorization
gem 'cancancan', '~> 2.0'

# Datetime validations
gem 'validates_timeliness', '~> 5.0.0.alpha3'

# ActiveModel::Serializer
gem 'active_model_serializers', '~> 0.10.0'

# Sidekiq for asynchronuous jobs
gem 'sidekiq'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # Database cleaner
  gem 'database_cleaner'

  # Fakes & factories
  gem 'factory_bot_rails'
  gem 'faker'

  # RSpec
  gem 'guard-rspec', require: false
  gem 'rspec-rails', '~> 3.8'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rails-erd'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
