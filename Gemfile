source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record
gem 'mysql2'

# Serializer
gem "active_model_serializers"

# Oauth provider
gem 'doorkeeper', '~> 0.7.0'

group :development, :test do
  gem 'jazz_hands'
  gem 'better_errors'
end

group :development do
  # gem 'newrelic_rpm'
end

group :test do
  gem 'machinist', '>= 2.0.0.beta2'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'rspec_candy'
  gem "rspec-rails", ">= 2.0.1"
  gem 'spork', '~> 1.0rc'
end
