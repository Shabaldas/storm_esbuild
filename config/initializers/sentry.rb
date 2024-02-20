Sentry.init do |config|
  config.dsn = Rails.env.production? ? 'https://facb42b23afd474a80bef9422777c4a7@o4505572422385664.ingest.sentry.io/4505572425334784' : nil
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  config.environment = 'production'
  config.enabled_environments = ['production']
  # or
  # config.traces_sampler = lambda do |_context|
  #   true
  # end
end
