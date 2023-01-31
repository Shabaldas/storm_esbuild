source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"

gem 'active_link_to'
gem "rails", "~> 7.0.4", ">= 7.0.4.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "redis", "~> 4.0"
gem "image_processing", "~> 1.2"

# gem "kredis"
# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
# Use Sass to process CSS
# gem "sassc-rails"

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "bullet"
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem "rubocop-faker"
  gem 'shoulda-matchers'
  gem 'faker'
  gem 'factory_bot_rails'
  gem "webmock"
end

group :development do
  gem "web-console"
  gem "spring"
end

group :test do
  gem "database_cleaner-active_record"
  gem "timecop", "~> 0.9.6"
  gem "capybara"
  gem "simplecov", require: false
  gem "selenium-webdriver"
  gem "webdrivers"
end
