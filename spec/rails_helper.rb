# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
require 'codeclimate-test-reporter'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
]

SimpleCov.start :rails do
  add_filter '/app/controllers/users'
  add_filter '/app/grape'
  add_filter 'app/channels/application_cable'
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/mailers/application_mailer.rb'

  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Jobs', 'app/jobs'
  add_group 'Services', 'app/services'
end

# DON'T FORGET TO UPDATE THE MINIMUM COVERAGE
# DON'T You dare reducing the minimum coverage without a good reason
# SimpleCov.minimum_coverage 99

require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'webmock/rspec'
require 'database_cleaner/active_record'
require 'active_storage_validations/matchers'
require 'pundit/rspec'
require 'sidekiq/testing'
require 'capybara/rails'
require 'capybara/rspec'
Sidekiq::Testing.fake!
ActiveJob::Base.queue_adapter = :test
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
  config.include ActiveStorageValidations::Matchers
  config.include Warden::Test::Helpers, type: :request
  config.include Warden::Test::Helpers, type: :feature
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include FactoryBot::Syntax::Methods
  config.fixture_path = "#{Rails.root}/spec/fixtures" # rubocop:disable Rails/FilePath

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
    # FactoryBot.lint
  end

  Shoulda::Matchers.configure do |conf|
    conf.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  WebMock.allow_net_connect!(net_http_connect_on_start: true)

  Capybara.register_driver :firefox do |mode|
    Capybara::Selenium::Driver.new mode, browser: :remote, desired_capabilities: :firefox
  end
  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
