require 'capybara-screenshot/rspec'
require 'webdrivers/chromedriver'

Capybara.default_max_wait_time = 5

Capybara.javascript_driver = :chrome_resized

Capybara.register_driver :chrome_resized do |app|
  args = ['no-sandbox', 'window-size=1366,2000']
  headed_mode = ENV.fetch('HEADED', false) == 'true'
  args << 'headless' unless headed_mode

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: Selenium::WebDriver::Chrome::Options.new(args:)
  )
end

Capybara::Screenshot.register_driver :chrome_resized do |driver, path|
  driver.browser.save_screenshot(path)
end
