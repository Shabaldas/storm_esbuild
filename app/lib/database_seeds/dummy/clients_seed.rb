# frozen_string_literal: true

module DatabaseSeeds
  module Dummy
    class ClientsSeed
      def execute
        return if Rails.env.production?

        25.times do
          FactoryBot.create :client
        end
      end
    end
  end
end
