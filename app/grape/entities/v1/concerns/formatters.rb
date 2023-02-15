# frozen_string_literal: true

module Entities
  module V1
    module Concerns
      module Formatters
        extend ActiveSupport::Concern

        included do
          format_with(:unix_time) do |datetime|
            datetime&.to_i
          end

          format_with(:stringify) do |attr|
            attr&.to_s
          end
        end
      end
    end
  end
end
