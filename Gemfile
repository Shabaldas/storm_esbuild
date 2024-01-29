source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'active_link_to'
gem 'ancestry'
gem 'anyway_config', '~> 2.6'
gem 'aws-sdk-s3', require: false
gem 'active_storage_validations'
gem 'canonical-rails', github: 'jumph4x/canonical-rails'
gem 'capistrano', '~> 3.11'
gem 'capistrano-rails', '~> 1.4'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-sidekiq', group: :development
gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
gem 'cssbundling-rails'
gem 'dotenv-rails', '~> 2.7'
gem 'devise'
gem 'devise-i18n'
gem 'image_processing', '~> 1.2'
gem 'foreman'
gem 'grape'
gem 'grape_on_rails_routes'
gem 'grape-entity'
gem 'httparty'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'pagy', '~> 6.4'
gem 'pg', '~> 1.1'
gem 'puma', '~> 6.3'
gem 'pundit', '~> 2.2'
gem 'phonelib'
gem 'ransack', '~> 3.2', '>= 3.2.1'
gem 'rails', '~> 7.0.6'
gem 'rails-i18n'
gem 'redis', '~> 4.0'
gem "sidekiq-cron"
gem "redis-namespace"
gem 'sidekiq', '~> 7.0.0'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'simple_form'
gem 'sentry-ruby'
gem 'sentry-rails'
gem "sentry-sidekiq"
gem "sentry-delayed_job"
gem "sentry-resque"
gem "sentry-opentelemetry"
gem "telegram-bot-ruby"
gem 'turbo-rails'

gem 'ed25519', '>= 1.2', '< 2.0'
gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'

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
  gem 'bullet', '~> 7.1.5'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem "pry-rails"
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rspec_api_documentation'
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem "rubocop-faker"
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'shoulda-matchers'
  gem 'webmock'
end

group :development do
  gem 'spring'
  gem 'web-console'
  gem 'capistrano-sidekiq'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'timecop'
  gem 'simplecov', require: false
  gem 'capybara'
  gem 'codeclimate-test-reporter', '~> 0.4.8'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
