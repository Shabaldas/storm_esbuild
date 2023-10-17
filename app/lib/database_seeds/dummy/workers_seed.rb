# frozen_string_literal: true

module DatabaseSeeds
  module Dummy
    class WorkersSeed
      def execute
        return if Rails.env.production?

        5.times do
          FactoryBot.create :worker
        end
      end
    end
  end
end
