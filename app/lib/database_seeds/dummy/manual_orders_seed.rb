# frozen_string_literal: true

module DatabaseSeeds
  module Dummy
    class ManualOrdersSeed
      def execute
        return if Rails.env.production?

        25.times do
          FactoryBot.create :manual_order
        end
      end
    end
  end
end
