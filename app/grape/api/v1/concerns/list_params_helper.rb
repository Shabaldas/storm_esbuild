# frozen_string_literal: true

module Api::V1
  module Concerns
    module ListParamsHelper
      extend ActiveSupport::Concern

      LIMIT_DEFAULT = 10
      LIMIT_MAX = 100

      included do
        helpers do
          params :list_params do |options|
            optional :limit, type: Integer, default: options[:limit_default] || LIMIT_DEFAULT,
                             values: {
                               value: 1..(options[:limit_max] || LIMIT_MAX),
                               message: "can range between 1 and #{options[:limit_max] || LIMIT_MAX}"
                             }
            optional :before, type: String
            optional :after, type: String
            mutually_exclusive :before, :after
          end
        end
      end
    end
  end
end
