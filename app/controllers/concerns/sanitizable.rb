# frozen_string_literal: true

module Sanitizable
  extend ActiveSupport::Concern
  include ActionView::Helpers::SanitizeHelper

  # single method to sanitize parameters
  def sanitize_parameters(fields_to_sanitize = {})
    fields_to_sanitize.transform_values do |value|
      # NOTE: this is encoding the value twice, also should decode the value
      # Rack::Utils.escape_html(sanitize(value))

      sanitize(value)
    end
  end

  # method for sanitizig and merge parameters
  def sanitize_and_merge_params(original_params, fields_to_sanitize)
    sanitized_params = fields_to_sanitize.each_with_object({}) do |field, memo|
      memo[field] = sanitize(original_params[field]) if original_params[field]
    end

    original_params.merge(sanitized_params)
  end
end
