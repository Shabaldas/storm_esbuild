# frozen_string_literal: true

namespace :client_find_or_create do
  desc 'Find or create Client from Manual Orders'
  task manual_order: :environment do
    ManualOrder.find_each do |manual_order|
      data = { first_name: manual_order.first_name, last_name: manual_order.last_name }
      client = Client.find_by({ phone_number: manual_order.phone_number[-10..] }.merge(data)) ||
               Client.find_by({ phone_number: "38#{manual_order.phone_number}" }.merge(data)) ||
               Client.find_by({ phone_number: manual_order.phone_number }.merge(data))
      if client.nil?
        client = Client.create do |new_client|
          new_client.first_name = manual_order.first_name
          new_client.last_name = manual_order.last_name
          new_client.phone_number = manual_order.phone_number
        end
      end

      worker_id = (manual_order.worker_id.presence || Worker.first.id)
      manual_order.update(client_id: client.id, worker_id:)
    end
  end
end
