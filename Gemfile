source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'

gem 'active_link_to'
gem 'cssbundling-rails'
gem 'dotenv-rails', '~> 2.7'
gem 'image_processing', '~> 1.2'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4', '>= 7.0.4.2'
gem 'redis', '~> 4.0'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

# gem "kredis"
# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"
gem 'bootsnap', require: false
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
# Use Sass to process CSS
# gem "sassc-rails"

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem "bullet"
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem "rubocop-faker"
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'shoulda-matchers'
  gem "webmock"
end

group :development do
  gem 'spring'
  gem 'web-console'
end

group :test do
  gem "database_cleaner-active_record"
  gem "timecop", "~> 0.9.6"
  gem "simplecov", require: false
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
