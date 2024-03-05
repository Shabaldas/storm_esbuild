# frozen_string_literal: true

namespace :client_find_or_create do
  desc 'Find or create Client from Manual Orders'
  task manual_order: :environment do
    ManualOrder.find_each do |manual_order|
      client = Client.find_or_initialize_by(phone_number: manual_order.phone_number[-10..], first_name: manual_order.first_name,
                                            last_name: manual_order.last_name) do |new_client|
        new_client.first_name = manual_order.first_name
        new_client.last_name = manual_order.last_name
        new_client.phone_number = manual_order.phone_number
      end
      client.save if client.new_record?

      worker_id = (manual_order.worker_id.presence || Worker.first.id)
      manual_order.update(client_id: client.id, worker_id:)
    end
  end
end
