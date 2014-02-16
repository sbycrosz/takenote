source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'newrelic_rpm'

group :staging do
  gem 'pg'
end

group :development, :test do
  gem 'mysql2'
end

gem 'doorkeeper', '~> 0.7.0'
gem 'bcrypt-ruby', '~> 3.0.0'

gem "active_model_serializers"
  
gem 'rack-cors', :require => 'rack/cors'

gem 'coveralls', require: false

gem 'jquery-rails'
gem 'uglifier'

group :development do
  gem 'guard-rspec', require: false
  gem 'guard-spork'
  gem 'terminal-notifier-guard'
  gem 'jazz_hands'
  gem 'better_errors'
end

group :test do
  gem "rspec-rails", ">= 2.0.1"
  gem 'simplecov', :require => false
  gem 'machinist', '>= 2.0.0.beta2'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'rspec_candy'
  gem 'spork', '~> 1.0rc'
end
