# frozen_string_literal: true

class AwsConfig < ApplicationConfig
  attr_config :ses_server, :ses_username, :ses_password, :s3_access_key_id, :s3_secret_access_key, :s3_bucket
end
