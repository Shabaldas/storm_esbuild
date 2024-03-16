# frozen_string_literal: true

module DatabaseSeeds
  module Dummy
    class ManualOrdersSeed
      def execute
        return if Rails.env.production?

        Client.all.each do |client|
          5.times do
            FactoryBot.create :manual_order, first_name: client.first_name,
                                             last_name: client.last_name, email: client.email,
                                             phone_number: client.phone_number,
                                             client_id: client.id
          end
        end
      end
    end
  end
end
